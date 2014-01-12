$ACCOUNT_STATUS=Hash.new
$ACCOUNT_STATUS[:active]="ACTIVE"
$ACCOUNT_STATUS[:demo]="DEMO"
$ACCOUNT_STATUS[:inactive]="INACTIVE"
$ACCOUNT_STATUS[:suspended]="SUSPENDED"

$USER_STATUS=Hash.new
$USER_STATUS[:active]="ACTIVE"
$USER_STATUS[:pending]="PENDING"
$USER_STATUS[:inactive]="INACTIVE"
$USER_STATUS[:suspended]="SUSPENDED"


$CONFIG_STATUS=Hash.new
$CONFIG_STATUS[:active]="ACTIVE"
$CONFIG_STATUS[:pending]="PENDING"
$CONFIG_STATUS[:inactive]="INACTIVE"

$HOSTNAME_STATUS=Hash.new
$HOSTNAME_STATUS[:active]="ACTIVE"
$HOSTNAME_STATUS[:pending]="PENDING"
$HOSTNAME_STATUS[:inactive]="INACTIVE"
$HOSTNAME_STATUS[:pending_removal]="PENDING_REMOVAL"


$HOSTNAME_CNAME_STATUS=Hash.new
$HOSTNAME_CNAME_STATUS[:resolved] = "RESOLVED" 
$HOSTNAME_CNAME_STATUS[:notresolved] = "NOT_RESOLVED"


$HOSTNAME_ORIGIN_STATUS=Hash.new
$HOSTNAME_ORIGIN_STATUS[:resolved] = "RESOLVED"
$HOSTNAME_ORIGIN_STATUS[:notresolved] = "NOT_RESOLVED"


$RULESET_STATUS=Hash.new
$RULESET_STATUS[:active]="ACTIVE"
$RULESET_STATUS[:pending]="PENDING"
$RULESET_STATUS[:inactive]="INACTIVE"
$RULESET_STATUS[:invalid]="INVALID"
$RULESET_STATUS[:staging]="STAGING"
$RULESET_STATUS[:stagepending]="STAGE_PENDING"
$RULESET_STATUS[:unassigned] = "UNASSIGNED"


$MOST_ACTIVE_RULESET_STATUSES=["ACTIVE","PENDING","STAGING","STAGE_PENDING"]


$PURGE_STATUS=Hash.new
$PURGE_STATUS[:success] = "SUCCESS"
$PURGE_STATUS[:failed] = "FAILED"
$PURGE_STATUS[:pending] = "PENDING"

$ROLES = [
{:name=>"System Administrator", :title=>"sysadmin", :system=>true},
{:name=>"Account Manager", :title=>"account_manager", :system=>false},
{:name=>"Account Owner", :title=>"account_owner", :system=>false}
]

#FEATURES = YAML.load_file("config/features.yml")


$OPERATORS = [
  {:name=>"equals", :operator=>"=="},
  {:name=>"doesnotequal", :operator=>"!="},
  {:name=>"contains", :operator=>"~"},
  {:name=>"doesnotcontain", :operator=>"~"},
  {:name=>"greaterthan", :operator=>">"},
  {:name=>"lessthan", :operator=>">"}
]

$VCL_TIMEOUT=2

$TOKEN_URL_EXAMPLE="http://www.mysite.com/index.html"
$TOKEN_EXPIRATION_TIME_EXAMPLE="2012-01-09 20:27:43 UTC"
$TOKEN_EXPIRATION_UNIX_EXAMPLE="1326140887"
$TOKEN_SECRET_EXAMPLE="73C95320-1D2E-012F-3BC6-482A140C2CEA"
$TOKEN_SIMPLE_MD5_EXAMPLE="7AF6B353A63CABCD8D5EF759EF8A029F"

