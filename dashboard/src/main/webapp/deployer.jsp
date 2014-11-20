<%@ page import="eu.seaclouds.platform.dashboard.ConfigParameters" %>
<%@ page import="brooklyn.rest.client.BrooklynApi" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SeaClouds Dashboard - Deployer</title>

    <!-- Core CSS - Include with every page -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">


    <!-- SB Admin CSS - Include with every page -->
    <link href="css/sb-admin.css" rel="stylesheet">

    <!-- SeaClouds configuration constants -->
    <script src="js/config.js"></script>

    <%! final BrooklynApi BROOKLKYN_API = new BrooklynApi(ConfigParameters.DEPLOYER_ENDPOINT); %>

</head>

<body>

<div id="wrapper">

    <nav class="navbar navbar-default navbar-fixed-top" role="navigation"
         style="margin-bottom: 0">
        <div class="navbar-header">
            <a class="navbar-brand extrnLink"
               href="http://www.seaclouds-project.eu/"> <img
                    class="img-responsive " src="img/seaclouds-header.png"
                    style="max-width: 100px; margin-top: -18px;" alt="SeaClouds project main website">
            </a>
            <button type="button" class="navbar-toggle" data-toggle="collapse"
                    data-target=".sidebar-collapse">
                <span class="sr-only">Toggle navigation</span> <span
                    class="icon-bar"></span> <span class="icon-bar"></span> <span
                    class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">SeaClouds Dashboard - Deploy new Application</a>
        </div>
        <!-- /.navbar-header -->

        <!-- TODO: Get alert number from Monitoring API -->
        <ul class="nav navbar-top-links navbar-right">

            <li id ="loading-spinner"></li>
            <li class="divider"></li>
            <li class="divider"></li>
            <li class="divider"></li>


            <li class="dropdown"><a class="dropdown-toggle"
                                    data-toggle="dropdown" href="#"><span class="badge">0</span><i
                    class="fa fa-bell fa-fw"></i> <i class="fa fa-caret-down"></i> </a>
                <ul class="dropdown-menu dropdown-alerts">
                    <li><a href="#">
                        <div>
                            <i class="fa fa-exclamation fa-fw"></i>This feature will be
                            available in prior releases<span
                                class="pull-right text-muted small">Just now</span>
                        </div>
                    </a></li>
                    <li class="divider"></li>

                    <!-- TODO: Open all alerts page -->
                    <li class="disabled"><a class="text-center" href="#"> <strong>See
                        All Alerts</strong> <i class="fa fa-angle-right"></i>
                    </a></li>
                </ul>
            </li>
                <!-- /.dropdown-alerts -->
            <!-- /.dropdown -->
            <li class="dropdown"><a class="dropdown-toggle"
                                    data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i>
                <i class="fa fa-caret-down"></i>
            </a>
                <ul class="dropdown-menu dropdown-user">
                    <li class="disabled"><a href="#"><i
                            class="fa fa-user fa-fw"></i>User Profile</a></li>
                    <li class="disabled"><a href="#"><i
                            class="fa fa-gear fa-fw"></i>Settings</a></li>
                    <li class="divider"></li>
                    <li><a href="#"><i class="fa fa-exclamation fa-fw"></i>
                        This feature will be available in prior releases</a></li>
                </ul>
                <!-- /.dropdown-user --></li>
            <!-- /.dropdown -->
        </ul>
        <!-- /.navbar-top-links -->

        <div class="navbar-default navbar-static-side" role="navigation">
            <div class="sidebar-collapse">
                <ul class="nav" id="side-menu">
                    <li><a href="index.html"><i class="fa fa-dashboard fa-home"></i>&nbsp;Home</a></li>
                    <li><a href="not-available.html" class=""><i class="fa fa-pencil-square-o"></i>&nbsp;Module Profile Designer</a></li>
                    <li><a href="not-available.html" class=""><i class="fa fa-code-fork"></i>&nbsp;Discoverer & Planner</a></li>
                    <li><a href="deployer.jsp" class=""><strong><i class="fa fa-download"></i>&nbsp;Deployer</strong></a></li>
                    <li><a href="monitor.jsp" class=""><i class="fa fa-dashboard"></i>&nbsp;Monitor</a></li>
                    <li><a href="sla.html" class=""><i class="fa fa-file-text-o"></i>&nbsp;SLA Service</a></li>

               </ul>
                <!-- /#side-menu -->
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- /.navbar-static-side -->
    </nav>

    <div id="page-wrapper">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">
                    Deployer 
                    <small>Brooklyn's YAML deploy method</small>
                </h1>
            </div>
            <!-- /.col-lg-12 -->
        </div>
        <!-- /.row -->
        <div class="row" id="page-content">

            <div class="col-lg-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-bar-chart-o  fa-fw"></i>Application Specification
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" id="yaml-input-panel-body">
                        <form role="form" onreset="resetForm()" onsubmit="submitYaml()">

                            <div class="form-group" id="text-form-group">
                                <label for="yaml-input-textarea">Paste your YAML here</label>
                                <textarea id="yaml-input-textarea" class="form-control" rows="3" onchange="switchFormInputTo('yaml-input-textarea')"></textarea>
                            </div>


                            <div class="form-group" id="file-form-group">
                                <label for="yaml-input-file">Choose a YAML File</label>
                                <input type="file" id="yaml-input-file" onchange="switchFormInputTo('yaml-input-file')">
                            </div>

                        <div class="pull-right">

                            <button type="reset" class="btn btn-default">Clear</button>
                            <button type="submit" class="btn btn-primary">Submit</button>
                        </div>


                        </form>


                    </div>
                    <!-- /.panel-body -->

                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-8 -->
            <div class="col-lg-4">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <i class="fa fa-gears fa-fw"></i>&nbsp;Deployer Status
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body" id="information-panel-body">
                        <% if(BROOKLKYN_API.getApplicationApi() != null){ %>
                        <h3 class="text-center text-success">Deployer Engine found. <br>
                        <small>Apache Brooklyn is listening in <%=ConfigParameters.DEPLOYER_ENDPOINT %> </small></h3>
                        <%} else{ %>
                        <h3 class="text-center text-success">Deployer Engine found. <br>
                        <small>Apache Brooklyn is listening in <%=ConfigParameters.DEPLOYER_ENDPOINT %> </small></h3>
                        <% } %>
                    </div>
                    <!-- /.panel-body -->
                </div>
                <!-- /.panel -->
            </div>
            <!-- /.col-lg-4 -->
        </div>
        <!-- /.row -->

    </div>
    <!-- /#page-wrapper -->

</div>
<!-- /#wrapper -->

<!-- Core Scripts - Include with every page -->
<script src="js/lib/jquery-1.10.2.js"></script>
<script src="js/lib/jquery.metisMenu.js"></script>
<script src="js/lib/bootstrap.min.js"></script>
<script src="js/lib/spin.min.js"></script>

<!-- SB Admin Scripts - Include with every page -->
<script src="js/sb-admin.js"></script>

</body>

<!-- Swagger JS API -->
<script src='js/lib/swagger.js' type='text/javascript'></script>
<script type="text/javascript">
    var SPINNER = new Spinner({lines: 13, length: 6, width: 2, radius: 5, top: "-5px"}).spin(document.getElementById("loading-spinner"));
    
    var CURRENT_FORM_INPUT = undefined;

    function resetForm(){
        $("#yaml-input-file").prop('disabled', false);
        $("#yaml-input-textarea").prop('disabled', false);

    }

    function switchFormInputTo(enabledForm){
        if(enabledForm == "yaml-input-textarea"){
            //TODO: Enable the form if the textarea is empty
            $("#yaml-input-file").prop('disabled', true);
        }else{
            $("#yaml-input-textarea").prop('disabled', true);

        }
        CURRENT_FORM_INPUT = enabledForm;
    }

    var CONTENT_ID = "page-content";

    var BACKEND_READY = false;

    function submitYaml(){
        $.get("/deployer", {yaml: $("#yaml-input-textarea").val()}, function(res){
            console.log(res);
        });
    }
</script>




</html>
