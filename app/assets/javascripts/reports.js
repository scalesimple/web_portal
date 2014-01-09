function insertParam(key, value, reload)
{
    key = escape(key); value = escape(value);

    var kvp = document.location.search.substr(1).split('&');

    var i=kvp.length; var x; 

    while(i--) 
    {
      x = kvp[i].split('=');

      if (x[0]==key)
      {
        x[1] = value;
        kvp[i] = x.join('=');
        break;
      }
    }

    if(i<0) {kvp[kvp.length] = [key,value].join('=');}

    reload = typeof reload != 'undefined' ? reload : true ; 
    //this will reload the page, it's likely better to store this until finished
    if (reload == true) {
     document.location.search = kvp.join('&'); 
    }
}

function insertParams(keys,values) {

    var len = keys.length ; 
    var kvp = document.location.search.substr(1).split('&');

    for(i=0; i<len; i++) { 
      var key = escape(keys[i]); 
      var value = escape(values[i]);

      var j=kvp.length; var x; 
      while(j--) 
      {
        x = kvp[j].split('=');
        if (x[0]==key)
        {
          x[1] = value;
          kvp[j] = x.join('=');
          break;
        }
      }

      if(j<0) {kvp[kvp.length ] = [key,value].join('=');}
    }
    
    //this will reload the page, it's likely better to store this until finished
     document.location.search = kvp.join('&'); 
}

function loadDailyCharts(bytes,hits,misses) {
    
        var colors = Highcharts.getOptions().colors,
        hitperc = hits/(hits+misses),
        gbserved = Math.round(bytes/1000000000)
        gblimit = gbserved * 1.2 

           // categories = ['MSIE', 'Firefox', 'Chrome', 'Safari', 'Opera'],
            name = 'Cache Hits/Misses',
            data = [{
                    y: hits,
                    color: '#27EB15',
                    name: "Hits"
                },
                {
                    y: misses,
                    color: '#F5A031',
                    name: "Misses"
                 }];

       
         var chart1 = new Highcharts.Chart({
            chart: {
                type: 'pie',
                renderTo: 'container',
              //  width: 400,
                backgroundColor:'rgba(255, 255, 255, 0.1)'
            },
            title: {
                text: 'Cache hit Rate',
                margin: 0
            },
            yAxis: {
                title: {
                    text: 'Cache Hit Rate'
                }
            },
            plotOptions: {
                pie: {
                    shadow: false,
                    center: ['50%', '50%'],
                     innerSize: '50%'
                }
            },
            tooltip: {
        	    //valueSuffix: '%'
            },
            series: [{
                name: 'Requests',
                data: data,
                size: '80%',
                dataLabels: {
                    formatter: function() {
                        return this.point.name ;
                    },
                    color: 'blue',
                    distance: 10
                }
            }]
         },
          function(chart1) {
            var circleradius=40; 
            chart1.renderer.text(Math.round(hitperc*100) + "%", 180, 210).css({
             // width: circleradius * 2,
              color: '#4572A7',
              fontSize: '22px',
              textAlign: 'center'
            }).attr({
            // why doesn't zIndex get the text in front of the chart?
               zIndex: 999
               }).add();
         }

         );

        /////////////////////////////////////////////
        //  GB SPeedometer 
        ////////////////////////////////////////////////

         var chart2 = new Highcharts.Chart({
                    chart: {
                      type: 'gauge',
                      renderTo: 'container2',
                      plotBackgroundColor: null,
                      plotBackgroundImage: null,
                      plotBorderWidth: 0,
                      plotShadow: false,
                     // width: 400,
                      backgroundColor:'rgba(255, 255, 255, 0.1)'
                     },
                    
                     title: {
                        text: 'GB Served'
                     },
                    
                     pane: {
                        startAngle: -150,
                        endAngle: 150,
                        background: [{
                            backgroundColor: {
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                                stops: [
                                    [0, '#FFF'],
                                    [1, '#333']
                                ]
                            },
                            borderWidth: 0,
                            outerRadius: '109%'
                        }, {
                            backgroundColor: {
                                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                                stops: [
                                    [0, '#333'],
                                    [1, '#FFF']
                                ]
                            },
                            borderWidth: 1,
                            outerRadius: '107%'
                        }, {
                            // default background
                        }, {
                            backgroundColor: '#DDD',
                            borderWidth: 0,
                            outerRadius: '105%',
                            innerRadius: '103%'
                        }]
                    },
                       
                    // the value axis
                    yAxis: {
                        min: 0,
                        max: gblimit ,
                        
                        minorTickInterval: null,
                        minorTickWidth: 1,
                        minorTickLength: 10,
                        minorTickPosition: 'inside',
                        minorTickColor: '#666',
                
                        tickPixelInterval: 30,
                        tickInterval: null,
                        tickWidth: 2,
                        tickPosition: 'inside',
                        tickLength: 10,
                        tickColor: '#666',
                        labels: {
                            step: 2,
                            rotation: 'auto'
                        },
                        title: {
                            text: ' GB Served'
                        },
                        plotBands: [{
                            from: 0,
                            to: gblimit,
                            color: '#55BF3B' // green
                        }]  
                      },
  
                      series: [{
                          name: 'Speed',
                          data: [gbserved],
                          tooltip: {
                              valueSuffix: ' GB Served'
                          }
                      }]  
         });

        
  
  
}; 

function loadMonthlyCharts(hits,bytes ) {

    var colors = Highcharts.getOptions().colors,

            name = 'Cache Hits/Misses',
            series = [
                {
                 name: "Cache Hit %",
                 data: hits
                }
               ],
            series2 = [
                {
                 name: "GB Served",
                 data: bytes
                }
               ]


       var chart1 = new Highcharts.Chart({
            chart: {
                type: 'spline',
                renderTo: 'container',
                width: 800,
                backgroundColor:'rgba(255, 255, 255, 0.1)'
            },
            series: series,
            tooltip: { 
              enabled: true,
              formatter: function()  { 
                            return  this.y + '%'; 
                         }
            },
            xAxis: { 
              type: "category",
              title: { text: "Days of the Month"}
            },
            yAxis: { 
              title: { text: 'Cache Hit %' },
              min: 0,
              max: 100
            },
            title: {
                text: 'Cache hit Rate'
            },
          });

        var chart2 = new Highcharts.Chart({
            chart: {
                type: 'spline',
                renderTo: 'container2',
                width: 800,
                backgroundColor:'rgba(255, 255, 255, 0.1)'
            },
            series: series2,
            tooltip: { 
              enabled: true,
              formatter: function()  { 
                            return  Math.round(this.y / 1000000000); 
                         }
            },
            xAxis: { 
              type: "category",
              title: { text: "Days of the Month"}
            },
            yAxis: { 
              title: { text: 'GB Served' },
              min: 0
            },
            title: {
                text: 'GB Served'
            },
          });


}