# Scalesimple - The Open Source CDN 


Scalesimple is an open source CDN platform.  The platform consists of multiple repositories to run the platform.  They are described below. The idea behind ScaleSimple is to build a basic foundation of a platform to allow anyone to have the ability to manage all of their Varnish caching rules from an easy UI.  

We have exposed access to the basic HTTP functionality (headers, query strings, etc) but have also added in more enterprise features like Geo Blocking and TokenAuth.  The concept we had was to allow anyone to have a very customized ruleset for their caching needs, without needing to know tons of VCL.  The major components of ScaleSimple are 

   * Varnish
   * Ruby/Rails
   * MongoDB
   * fluentd
   * vagent2 
   * RabbitMQ


PLEASE NOTE:  We have a *LOT* to do still to make things even close to reasonable.  That was the idea behind us open sourcing, its getting help from the community.  We are looking for contributors to help make the platform more configurable and more customizable.  Some areas where we *REALLY* need help

  * Unit Tests.  Sorry, we slacked and we suck and now we are paying the price.  We need rspec tests and varnishtest tests 
  * We need to convert all the Rails constants to using a .env file.  This makes deployment "much" easier 
  * Documentation.  We have been at this for a while, but coming in cold, its hard to know whats going on.  We need proper documentation 
  * First time setup scripts.  We need a better bootstrap so people can get up and running quickly.  We have been running this locally for so long we havent started from scratch in a while, and its probably broken.
  * More VMODs !  The more cool customization we have here, the more robust the platform will be 

### Web Portal [github link](http://github.com/scalesimple/web_portal)

The web portal is the main UI for configuring all of the rules, rulesets, hostnames, etc.  The UI run on rails 3.2 and Mongo 2.2 (yes we are working on a rails 4 upgrade).  TO get started, when you check out the repo and you have mongo running, you should run 

  * bundle install 
  * rake db:schema:load 
  * rake db:seed
  
This should create a default admin user for you that you can start configuring. The UI also currently relies on publishing messages to a RabbitMQ node, so if you dont have rabbitMQ running, you may experience some issues with after_save events in the models.  We currently use RabbitMQ to setup jobs to update DNS and configure Varnish.

Files you should edit 

   * config/mongoid.yml
   * config/environments/production.rb
   * config/environments/development.rb
   * config/initializers/global.rb
   * config/initializers/devise.rb
   * config/unicorn.rb
  
To start the server

    bundle exec unicorn -c config/unicorn.rb -D -E [development | production]

### VMODS [github link](http://github.com/scalesimple/vmods)

These are the vmods that are required to run the platform.  They are for dealing with headers, token-auth, geoip blocking etc.  You shoudl compile each of these VMODs and isntall them to each of your varnish nodes. The typical way to install them is 

    VARNISHSRC=/path/to/varnish/src VMODDIR=/path/to/compiled/vmods ./configure 
    make
    make install
    
    then .. 
    cp /path/to/compiled/vmods/* /usr/lib/varnish/vmods  (or wherever your varnish lib dir is, usually /usr/lib/varnish or /usr/local/lib/varnish )
    
### Consumers [github link](http://github.com/scalesimple/consumers)

  We leverage RabbitMQ to handle jobs offline.  Currently these jobs are  
    * Generating new VCL
    * Pushing new VCL to nodes 
    * Creating/Updating DNS.  currently we are wired into DnsMadeEasy.  
    
The consumers require an active RabbitMQ installation (the same one the UI talks to).  We also require Vagent2 to be installed on each of the varnish nodes.  This is how we communicate with the varnish nodes to push updates.

To run these, modify config/config.yml in each of the consumers.  Then you can start the consumers (there is one in a dns directory and one in a vcl directory) by running


    ruby runit.rb 


### Reporting [github link](http://github.com/scalesimple/fluentd-mongo-timeseries)

We are using fluentd to integerate with reporting.  To start, we had limited storage availability so we are only setup to handle reporting on a daily and monthly basis.  More granularity would not be difficult to wire in, we were just limited on storage space.  To run the reporting engine a few things need to happen.

Firstly, you need to ensure you have varnishncsa running on each of your varnish nodes.  The current supported syntax is 

     varnishncsa -F %t %{Host}i %b %s %{Varnish:hitmiss}x -w /var/log/varnish.log
     
We were being kind of cheap by only logging what we needed , since currently we dont support tracking any URLs.  Again, this can all be easily modified if you wanted more detailed reporting to include URLs, etc.

Once you have varnish logging you need to setup fluentd.  On the varnish nodes, fluentd should simply be setup with the log tailer of /var/log/varnish.log and forwarding all traffic to a central fluentd node.

On the central fluentd node, collecting all the log data, you need to setup a matcher to push the traffic to the mongo plugin.  This is done with a snippet like the following

     <match varnish.**>
      flush_interval 5s
      type mongotimeseries
      host localhost
      database stats
     </match>

This will flush every 5 seconds, the log buffer to the mongotimeseries plugin.  You can also configure the hostname and database name for your stats.  Please note, that this fluentd plugin is pretty customized to the varnishncsa format that we have described so far.  So if you want more logging for URLS, etc then you are going to need to modify the mongo plugin.  We wrote a custom one to handle the rolling up of data.