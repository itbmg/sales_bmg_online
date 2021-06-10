<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportsPage.aspx.cs" Inherits="ReportsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        #all_text span
{
    text-decoration:underline;
    background-color:yellow;    
}
body{background:url(images/bgfit.png) no-repeat center center fixed;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover}h1,h2{color:#39363f;line-height:30px}h3,h4{color:#4d4d4d;line-height:15px}h2.title{padding-left:10px}h2{font-size:18px}h3{font-size:16px}h4{font-size:14px}.panel-title{margin:0!important}#gts-bounce-nav .client-logo{max-height:45px;margin:1px}#gts-bounce-nav .navbar-inner .nav>li{background-color:#464c5a;margin-right:1px}#gts-bounce-nav .navbar-inner .nav>li>.payroll-menu{padding:5px 10px}#gts-bounce-nav .navbar-inner .nav>li>.payroll-menu button{margin:0}#gts-bounce-nav .navbar-inner .nav>li>a{padding:10px 20px 9px 20px;font-weight:bold}#gts-bounce-nav .navbar-inner .nav>li>a.tight{padding:10px 8px 9px 8px}#gts-bounce-nav .navbar-inner .nav>li>a>*{display:inline-block;vertical-align:middle;line-height:20px}#gts-bounce-nav .navbar-inner .nav>li>a>i{font-size:1.5em;margin-right:5px}#gts-bounce-nav .navbar-inner .brand{padding:2px 20px 1px 30px}.masthead{height:55px;padding:0 10px;background:-moz-linear-gradient(left,#fff 28%,rgba(125,185,232,0) 100%);background:-webkit-gradient(linear,left top,right top,color-stop(28%,#fff),color-stop(100%,rgba(125,185,232,0)));background:-webkit-linear-gradient(left,#fff 28%,rgba(125,185,232,0) 100%);background:-o-linear-gradient(left,#fff 28%,rgba(125,185,232,0) 100%);background:-ms-linear-gradient(left,#fff 28%,rgba(125,185,232,0) 100%);background:linear-gradient(to right,#fff 28%,rgba(125,185,232,0) 100%);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff',endColorstr='#007db9e8',GradientType=1)}.masthead img{margin:5px 5px 0 5px;vertical-align:middle}.masthead .navbar-secondary{margin-bottom:5px;background-color:rgba(255,255,255,0.8);border-radius:0 0 4px 4px}.masthead .navbar-secondary .navbar-inner{border-radius:0;padding-left:0}.masthead .navbar-secondary .nav>li>a{text-shadow:none;color:#999;padding:4px 10px}.masthead .navbar-secondary .nav>li>a.focus,.masthead .navbar-secondary .nav>li>a:hover{color:#fff}.masthead #intuitPlatformAppMenu{right:auto}.navbar .brand{padding-left:30px}.navbar-static{margin-bottom:5px}.navbar-static .navbar-inner{border-radius:0;padding-left:0;padding-right:0}#admin-ribbon{height:35px;padding:2px;background-color:#68bcff}#admin-ribbon #_payroll-menu .mnu-btn .month{padding-right:3px}.container2{overflow:auto;width:100%}.container2.fixed-top{margin-top:105px}.content{float:left;overflow:hidden;width:100%;position:relative;margin-top:10px}.inner-content{position:relative;float:left;right:80%;width:100%}.inner-content a{cursor:pointer}.inner-content .side-bar{float:left;position:relative;width:20%;left:80%}.inner-content .side-bar a,.inner-content .side-bar a:visited{color:#333;cursor:pointer}.inner-content .side-bar a:hover{color:white}.inner-content .side-bar .normal-advanced{font-size:.8em;text-align:center;margin-bottom:10px}.inner-content .side-bar .normal-advanced a,.inner-content .side-bar .normal-advanced a:visited,.inner-content .side-bar .normal-advanced a:hover{color:#666}.inner-content .app-content{background-color:rgba(252,252,252,0.95);float:left;position:relative;width:79%;left:80%}.inner-content.full-add,.inner-content.full-remove{-webkit-transition:all linear .1s;-moz-transition:all linear .1s;-o-transition:all linear .1s;transition:all linear .1s}.inner-content.full{right:99%}.inner-content.full .side-bar{left:99%;width:1%}.inner-content.full .app-content{left:99%;width:98%}.inner-content .main-content{padding:10px}.inner-content .main{padding:15px}.inner-content .accordion{padding:0 4px 0;margin-bottom:0}.app-container{padding-bottom:115px;min-height:650px}.app-topbar{font-size:.9em;color:#808080}.app-topbar .app-title{margin-right:30px}.app-topbar .app-title i.main{color:#39363f}.app-topbar .app-title h2{margin-bottom:0}.app-topbar .app-tabs .nav{margin:0}.app-topbar .app-tabs .nav>li>a{border-radius:0}.app-topbar .app-tabs .nav>li.active{margin-top:-1px}.app-topbar .app-tabs .nav>li>a:hover{background-color:transparent}.app-topbar .app-tabs .nav>.active>a,.app-topbar .app-tabs .nav>.active>a:hover,.app-topbar .app-tabs .nav>.active>a:focus{border-color:#abcde8 #abcde8 transparent #abcde8;border-bottom-width:2px}.app-topbar .app-tabs ul{padding:0;margin-bottom:0}.hide-sidebar{margin:5px 15px 5px 5px;float:left}.page-footer{margin-top:0;color:#fff;width:100%;overflow:auto}.footer_links{font-size:.85em;color:#fff;padding:10px}.footer_links a,.footer_links a:hover,.footer_links a:active,.footer_links a:visited{color:#fff}.powered-by-info{float:right}.powered-by-info .powered-by-label{font-size:.8em}.powered-by-info .powered-by-logo{background:transparent url("images/powered-by.png") left center no-repeat;width:155px;height:65px;padding-right:10px}.service-provider-info{float:left;margin-right:10px}.service-provider-info .service-provided-by{font-size:.8em}.service-provider-info .service-provider-logo{background:transparent left top no-repeat;height:45px;line-height:45px;width:180px}.version{font-size:.95em;font-weight:bold;color:#fff}.gts-link{cursor:pointer}.inner-col{margin-right:10px;padding:10px}.inner-h{padding-left:10px;padding-right:10px}.inner-v{padding-top:10px;padding-bottom:10px}div.overflow-x{overflow-x:auto}.clickable{cursor:pointer}.block{border-radius:4px;border:1px solid #abcde8}.report-block{margin-bottom:20px;background-color:white;width:30%;margin-left:1.5%}.report-block h3,.report-block h4{color:#fff;background-color:#0f74a2;padding-left:5px;margin:0}.report-block h4{padding:5px 5px 0 5px;line-height:25px;overflow:hidden;white-space:nowrap}.news-block{margin-bottom:20px;background-color:white;width:47.5%;margin-left:2%}.news-block .inner{padding:10px}.news-block h4{padding:0;line-height:25px;overflow:hidden;margin:0;font-size:1.3em;color:#333;white-space:nowrap}.news-block .more{font-weight:bold;color:#666}section.panel{padding:5px;border-bottom:1px solid #fbfdfe}section.panel.omega,section.panel:last-child{border-bottom:0}section{margin-bottom:10px}ul.menu{list-style-type:none;margin:10px}ul.menu li{margin:10px;padding-left:0}.tab-container{padding:2px 2px 0 2px;background-color:#edf3f7}.ng-cloak{display:none!important}.checkbox-text{vertical-align:middle;display:inline-block;margin:4px 0 0}.nav-tabs{border-color:#abcde8;padding-left:20px}.nav-tabs>.active>a{outline:0;background-color:rgba(252,252,252,0.95)}.nav-tabs>.active>a,.nav-tabs>.active>a:hover,.nav-tabs>.active>a:focus{background-color:rgba(252,252,252,0.95);border-color:#abcde8 #abcde8 transparent #abcde8}.nav-tabs>li>a:hover{background-color:rgba(252,252,252,0.95);border-color:#abcde8}.nav-tabs .nav-tab.active a{background-color:rgba(252,252,252,0.95)}.admin-home-page .nav-tabs{border-color:transparent}.admin-home-page .nav-tabs>.active>a,.admin-home-page .nav-tabs>.active>a:hover,.admin-home-page .nav-tabs>.active>a:focus{background-color:transparent;color:#000;border-color:transparent #bcbdda transparent #bcbdda}.admin-home-page .nav-tabs>li>a{background-color:rgba(252,252,252,0.95);color:#000;border-color:transparent #bcbdda transparent transparent;margin-right:0;border-radius:0}.admin-home-page .nav-tabs>li>a:hover{background-color:#fff;border-color:transparent #bcbdda transparent transparent}.nav-item{padding:8px 14px;display:block;margin:0 0 -1px;text-decoration:none;outline:0;color:#333;font-size:1.1em}.nav-item.active{font-weight:bold}.nav-item:hover{background-color:rgba(15,116,162,0.5)}.nav-item:hover .icon-chevron-right{opacity:.5}.gt-sidebar{padding:0;margin:0 5px 5px 5px}.gt-sidebar .search{margin:4px 14px 4px 4px;padding:0;text-align:center}.gt-sidebar .search input{width:100%;box-sizing:border-box;-moz-box-sizing:border-box;margin:0;border-radius:10px;height:auto}.gt-sidenav{padding:0}.gt-sidenav .l2{padding:0}.gt-sidenav .accordion-group{margin:0;border:0;border-radius:0}.gt-sidenav .accordion-toggle{padding:0}.gt-sidenav .accordion-body .accordion-inner{padding:0;border:0}.gt-sidenav .icon-chevron-right{float:right;margin-top:2px;margin-right:-5px;opacity:.25}.gt-sidenav .active .icon-chevron-right,.gt-sidenav a.active:hover .icon-chevron-right{background-image:url(bootstrap/img/glyphicons-halflings-white.png);opacity:1}.gt-sidenav .nav-item{margin:0 0 1px 0;padding:0 10px 0 0}.gt-sidenav .nav-item:hover{background-color:transparent}.gt-sidenav .nav-item.end-piece{height:5px;background-color:#1395d1;padding:1px 0;margin-right:10px}.gt-sidenav .nav-item a{display:inline-block;width:100%;box-sizing:border-box;-moz-box-sizing:border-box;padding:8px 10px;font-weight:normal;background-color:#1395d1;color:#fff;text-decoration:none;outline:0}.gt-sidenav .nav-item a span{margin-right:0!important;overflow:hidden;white-space:nowrap;display:inline-block}.gt-sidenav .nav-item a:visited{color:#333;text-decoration:none}.gt-sidenav .nav-item a:hover{background-color:#0f74a2;text-decoration:none}.gt-sidenav .nav-item a:hover .icon-chevron-right{opacity:.5}.gt-sidenav .nav-item.level2.active{background:url(images/nav-active2.png) no-repeat center right}.gt-sidenav .nav-item.level2.active a{color:#fff}.gt-sidenav .nav-item.level2 a{background-color:#4ba3cb;color:#f2f2f2;padding-left:40px;font-size:.85em}.gt-sidenav .nav-item.level2 a:hover{background-color:#3389b0;text-decoration:none}.gt-sidenav .nav-item.active{background:url(images/nav-active.png) no-repeat center right}.gt-sidenav .nav-item.active a{font-weight:bold;text-decoration:none}.table-border{border:1px solid #abcde8;border-radius:5px}.table-div .header{border-bottom:1px solid #abcde8;color:#39363f;background-color:#98cae0;padding:5px 0;text-align:center}.app-content td.right,.app-content th.right{text-align:right}.app-content td.center,.app-content th.center,.app-content .center{text-align:center}.app-content td.large,.app-content th.large{font-size:1.2em;vertical-align:middle}.app-content td.v-middle{vertical-align:middle}.app-content .small{font-size:.85em}.app-content .big{font-size:1.20em}.app-content .sub{color:#0170a0}.app-content .sub-title{font-size:.80em;color:#0170a0;border-bottom:1px dotted #0ab4fd;text-transform:uppercase}.app-content .right{text-align:right}.app-content .popover{text-align:left}tr.footer td{font-weight:bold}select.multi option{padding:8px 5px}.gts-flat-dropdown-menu{max-width:900px}.gts-flat-dropdown-menu td{vertical-align:top}.gts-user-dropdown-menu{padding-left:6px;padding-right:6px;width:300px}.gts-user-dropdown-menu .user-photo{width:64px;height:64px;vertical-align:top;background:none no-repeat scroll 0 0 transparent}.gts-user-dropdown-menu .user-details{display:inline-block;width:195px}.gts-user-dropdown-menu .user-details .user-name{font-size:1.3em;font-weight:bold;padding:4px 15px 6px;color:#39363f;text-shadow:1px 1px 2px #c9c9c9}.gts-user-dropdown-menu .user-footer{width:100%}.gts-user-dropdown-menu .user-footer .user-signout{clear:none!important;margin-right:5px;width:115px}.gts-user-dropdown-menu .user-footer .user-switch{clear:none!important;margin-right:5px;width:135px}.gts-user-dropdown-menu .gts-user-dropdown-swithuser{color:#333}.gts-user-dropdown-menu .gts-user-dropdown-swithuser .switch-user-goback span{cursor:pointer;font-size:.9em}.gts-user-dropdown-menu .gts-user-dropdown-swithuser .switch-user-list li{cursor:pointer;padding:10px;border:1px solid rgba(15,116,162,0.5)}.gts-user-dropdown-menu .gts-user-dropdown-swithuser .switch-user-list li:hover{background-color:rgba(15,116,162,0.5)}.gts-nav-dropdown-ntfn .row{margin:0;padding:0;width:300px}.gts-nav-dropdown-ntfn .span4{width:100%}.gts-nav-dropdown-ntfn h4{padding:0 3px;background-color:#fff;color:#4d4d4d}.gts-ntfn-content{background-color:#edf3f7}.gts-ntfn-content>.ntfn-body{overflow-y:scroll;max-height:300px;min-height:250px;border-top:1px solid #abcde8}.gts-ntfn-content section.item{cursor:default;position:relative;margin:0;padding:0 5px 5px 5px;min-height:25px;_height:25px;border-bottom:1px solid #d3e5f3;color:#595959;font-size:.9em}.gts-ntfn-content section.item.even{background-color:#fff}.gts-ntfn-content section.item .last{padding-bottom:0}.gts-ntfn-content section.item:hover{background-color:#dbe7ef;border-bottom:1px solid #d3e5f3}.gts-ntfn-content section.item>header{color:ligthen(#333,5%)}.gts-ntfn-content section.item>header h5{font-size:.95em;font-weight:500;margin:0}.gts-ntfn-content section.item>footer{padding-bottom:0}.gts-ntfn-content section.item>footer .close{font-size:1em;opacity:.5}.gts-ntfn-content .link{cursor:pointer}.gts-ntfn-content .gts-ntfn-ico-info{background-image:url(images/ntfn-info-16X16.png)}.gts-ntfn-content .gts-ntfn-ico-warn{background-image:url(images/ntfn-warn-16X16.png)}.gts-ntfn-content .gts-ntfn-ico-error{background-image:url(images/ntfn-error-16X16.png)}.gts-ntfn-content .gts-ntfn-ico-wf{background-image:url(images/ntfn-wf-16X16.png)}#gts-nav-ntfn-launcher a{font-weight:bold;font-size:.85em;background-color:#f0f0f0;background-color:rgba(240,240,240,0.7);color:#f00;color:rgba(255,0,0,0.9);border-radius:5px;border:1px solid #CCC;margin:4px 8px 0 8px;padding:0 6px;line-height:18px!important}#gts-nav-ntfn-launcher a:hover{background-color:#fafafa;color:#f00;cursor:pointer}.gts-nav-flat-dropdown-menu>table{margin-bottom:0}.gts-nav-flat-dropdown-menu>table td{border:0 none}.gts-nav-flat-dropdown-menu>table td .gts-nav-col{width:200px}.gts-nav-flat-dropdown-menu>table td .gts-nav-col section header{font-size:1.2em;margin-left:5px;margin-top:10px;color:#39363f}.gts-nav-flat-dropdown-menu>table td .gts-nav-col section header:first{margin-top:0}.gts-nav-flat-dropdown-menu>table td .gts-nav-col section ul{margin:0 10px 0 0;max-height:265px;overflow-y:hidden}.select2-container{vertical-align:middle}.select2-container-multi .select2-choices{border:1px solid #cecece;border-radius:4px}.select2-container .select2-choice{height:28px;line-height:28px}.gts-flat-dropdown-menu-more{border-top:1px solid #847e90}.gts-menu-view-flat .gts-nav-section{padding:10px}.gts-menu-view-flat .gts-nav-section header{font-weight:500;font-size:1.4em;color:#39363f;margin:10px 0 5px 0}.gts-menu-view-flat .gts-nav-section ul{margin-left:0}.gts-menu-view-flat .gts-nav-section li{list-style-type:none}.gts-menu-view-flat .gts-nav-section li a{font-size:1.1em;padding:8px 5px;text-decoration:none;color:#333;display:block;border-bottom:1px solid #0f74a2}.gts-menu-view-flat .gts-nav-section li a:hover{background-color:#1395d1}ul.page-path-selector{padding:5px 0 5px 5px}ul.page-path-selector li a{color:#333;font-size:.9em;padding:8px 5px;text-decoration:none;display:block;border-bottom:1px solid #43b8ee}ul.page-path-selector li.page-path-selector-group.expanded>a{font-weight:600;font-size:1.0em;cursor:default}ul.page-path-selector ul.page-path-selector-group-container>li{margin-left:10px}ul.page-path-selector .ui-widget-content{border:0}ul.page-path-selector li.ui-selected a{background-color:#0f74a2}ul.page-path-selector li.ui-selectee a:hover{background-color:rgba(15,116,162,0.5)}.page-container>header,.bottom-border{border-bottom:1px solid #abcde8;margin:0 10px 10px 0}.top-bottom-border{border-top:1px solid #abcde8;border-bottom:1px solid #abcde8;padding:5px 0}.ajax-message-wrapper{position:relative;width:100%;z-index:1200}#ajax-messages{display:none;position:fixed;right:5px;top:45px}#gts-ajax-loading{background:url("images/ajax-loader.gif") no-repeat scroll center center transparent;margin-right:5px;padding:10px 16px}.list-view-item{margin-bottom:10px}.list-view-item header{background-color:rgba(15,116,162,0.19999999999999996);padding:5px;cursor:pointer}.gts-activities-review-summary .list-view-item-footer{text-align:center}.gts-activities-review-summary .wf-search-btn{margin-right:15px}.gts-alert-modal .modal-body{min-height:35px}.gts-alert-modal .icon-gts-alert{background-color:transparent;background-position:center center;background-repeat:no-repeat;float:left;height:37px;width:47px}.gts-alert-modal .icon-gts-alert-error{background-image:url("images/icon-error.gif")}.gts-alert-modal .icon-gts-alert-info{background-image:url("images/icon-info.gif")}.gts-alert-modal .icon-gts-alert-warning{background-image:url("images/icon-warning.gif")}.gts-alert-modal .icon-gts-alert-question{background-image:url("images/icon-question.gif")}.gts-combo{display:inline;position:relative}.gts-combo input.cb-autocomplete{padding-right:20px;display:inline-block}.gts-combo i.gtscombo-queryall{position:absolute;right:4px;top:-1px;margin-top:3px;cursor:pointer}.gts-emloyee-cc input.cc-field{display:inline-block}.gts-icon16{background-repeat:no-repeat;display:inline-block;height:16px;line-height:16px;vertical-align:text-top;width:16px}.gts-icon32{background-repeat:no-repeat;display:inline-block;height:32px;line-height:32px;vertical-align:text-top;width:32px}.gts-display-type{margin-bottom:10px}#dashboard-tabs ul{margin-bottom:0}.dashboard-container{background:#39363f url(images/db.jpg) repeat;border-bottom:1px solid #abcde8;margin:0;padding:3px 0}.dashboard{display:none;min-height:222px;padding:5px 0}.dashboard header{cursor:pointer;padding-left:20px;background-color:#0f74a2}.dashboard table{width:100%}.dashboard td{text-align:left}.dashboard.active{display:block!important}.scrollable{background-color:#fff;background-color:rgba(255,255,255,0.9);position:relative;overflow:hidden;width:845px;height:220px;border:1px solid #ccc;border-radius:8px;box-shadow:inset 1px 1px 3px #333;float:left}.scrollable .items{width:20000em;position:absolute;clear:both}.scrollable .items .panel-wrapper{float:left}.scrollable .items .panel{min-width:150px;float:left;padding:5px 10px;margin:5px;border-left:1px solid #333;border-left:1px solid #39363f;text-align:center}.scrollable .items .panel-content{height:175px}.scrollable .items .panel-footer{height:20px;padding-top:4px}.scrollable .items .panel.alpha{border-left:none}.scrollable .items .panel h4{margin-bottom:10px}.scrollable .user-photo{width:128px;height:128px}.scrollable .greeting{width:256px;height:175px;background-color:#cdcdcd;margin:5px}.scrollable img{float:left;margin:20px 5px 20px 21px;background-color:#fff;padding:2px;border:1px solid #ccc;width:100px;height:75px;-moz-border-radius:4px;-webkit-border-radius:4px}.scrollable .active{border:2px solid #000;position:relative;cursor:default}.scrollable-wrapper a.browse{background:url(images/arrow/hori_large.png) no-repeat;background:url(images/scrollbutton.png) no-repeat;display:block;width:30px;height:30px;float:left;margin:80px 10px;cursor:pointer;font-size:1px}.scrollable-wrapper a.right{background-position:-40px 0;clear:right;margin-right:0}.scrollable-wrapper a.left{margin-left:4px}.scrollable-wrapper a.up,.scrollable-wrapper a.down{background:url(images/arrow/vert_large.png) no-repeat;float:none;margin:10px 50px}.scrollable-wrapper a.up:hover{background-position:-30px 0}.scrollable-wrapper a.up:active{background-position:-60px 0}.scrollable-wrapper a.down{background-position:0 -30px}.scrollable-wrapper a.down:hover{background-position:-30px -30px}.scrollable-wrapper a.down:active{background-position:-60px -30px}.scrollable-wrapper a.disabled{visibility:hidden!important}.dashboard .panel td.swipe-in{width:75px;text-align:center}.dashboard .panel td.swipe-out{width:75px;text-align:center}td.heading{text-align:right;color:#839faa;font-size:.9em}td.data{border-left:none!important}.table-info td.data{width:32%}.table-info td.heading{width:18%}.table-info th{border-bottom:1px solid #8c8c8c;color:#39363f;background-color:#98cae0;text-align:center;font-size:.85em;font-weight:normal}.table-info tfoot td{font-weight:bold;border-top:1px solid #8c8c8c}.td-align-top{vertical-align:top}.td-4{width:4%}.td-5{width:5%}.td-10{width:10%}.td-15{width:15%}.td-17{width:17%}.td-20{width:20%}.td-25{width:25%}.td-33{width:33%}.td-40{width:40%}.td-48{width:48%}.td-50{width:50%}.td-60{width:60%}.td-67{width:66%}.td-75{width:75%}.w-50{width:50%;margin:0 auto}.w-75{width:75%;margin:0 auto}.w-90{width:90%;margin:0 auto}.w-100{width:100%;margin:0 auto}.no-overflow{text-overflow:ellipsis;display:inline-block;white-space:nowrap;overflow:hidden;height:25px;line-height:25px;vertical-align:middle}td.buttons{background-color:rgba(15,116,162,0.7)}textarea.h-medium{height:150px}.toolbar{background:#edf3f7;border:1px solid #edf3f7;height:30px;padding:3px}.toolbar button,.toolbar a{margin-bottom:9px}.panel-left{float:left}.panel-right{float:right}.ytd-total td{border-top:1px solid #8c8c8c;border-bottom:1px solid #8c8c8c;color:#247996}.ytd-grand-total td{font-weight:800;font-size:1.1em;color:#1f6881}.ytd-heading{font-weight:500;font-size:1.1em}.ytd-component-name{font-size:.95em;width:120px;white-space:nowrap;overflow:hidden}.it-header{padding:5px;background-color:#f7efd7;cursor:pointer}.it-header.minus h4{color:#e22828}.it-header.highlight{background-color:#efdeac}.it-header.highlight h4{font-weight:bold}.it-header:hover{background-color:#f3e7c2;border:1px solid #e2c56d}.it-header h4{font-weight:normal}.fixed-left{width:235px;overflow-x:auto}.scroll-right{overflow-x:auto}.btn-container{height:32px}.img_left{margin-right:5px}.gts-employee-search{line-height:15px;min-height:38px}.gts-employee-search:hover{background-color:#eff5f7}.gts-employee-search:hover .es-button{display:block}.gts-employee-search.es-unselected .es-display .es-display-name{padding-top:10px}.gts-employee-search .es-display{height:38px;cursor:pointer}.gts-employee-search .es-display h4{cursor:pointer;min-width:125px;margin:5px 0 0 0}.gts-employee-search .es-display img{padding:3px}.gts-employee-search .es-button{margin:8px 0 0 20px;display:none}.gts-employee-search .es-search{padding:6px 0 0 6px;line-height:27px}.gts-employee-search i.cancel-search{cursor:pointer}.gts-employee-search .clear-search{display:none;margin:8px 0 0 10px}.gts-employee-search .clear-search i{cursor:pointer}.gts-employee-search.es-unselected .clear-search{display:none}.gts-employee-search-menu.ui-autocomplete{z-index:1003!important}.tt-comment{margin-bottom:15px}.tt-comment .tt-description{font-size:1.2em;padding:5px}.tt-comment .tt-commenter{background-color:#EEE;margin:0;padding:2px 10px;font-size:.9em;border-bottom:1px solid #dfdfdf}.form-tight{margin-bottom:3px}.form-tight .control-group{margin-bottom:0}header.msg-top,div.msg-bottom{padding:5px;font-style:italic;font-size:.9em}header.msg-top{background-color:rgba(15,116,162,0.5);margin:3px 0 10px 0}div.msg-bottom{background-color:#c3c3c3;margin:10px 0 3px 0}[class^="icon-claims-"],[class*=" icon-claims-"]{background-image:url("images/0016_0412_icon-claims-32-x-32.png");background-position:14px 14px;background-repeat:no-repeat;display:inline-block;height:32px;line-height:32px;vertical-align:middle;width:32px}.icon-claims-apartment{background-position:0 -10px}.icon-claims-entertainment{background-position:-42px -10px}.icon-claims-taxi{background-position:-84px -10px}.icon-claims-travel{background-position:-126px -10px}.icon-claims-accommodation{background-position:-168px -10px}.icon-claims-overseas{background-position:-210px -10px}.icon-claims-airport{background-position:-252px -10px}.icon-claims-mobile{background-position:-294px -10px}.icon-claims-car{background-position:-336px -10px}.icon-claims-laundry{background-position:-378px -10px}.icon-claims-drinks{background-position:-420px -10px}.icon-claims-gift{background-position:-462px -10px}.icon-claims-break{background-position:-504px -10px}.icon-claims-breakfast{background-position:-546px -10px}.icon-claims-lunch{background-position:-588px -10px}.icon-claims-dinner{background-position:-630px -10px}.icon-claims-technology{background-position:-672px -10px}.icon-claims-hotel{background-position:-714px -10px}.icon-claims-telephone{background-position:-756px -10px}.icon-claims-medical{background-position:-798px -10px}.icon-claims-dental{background-position:-840px -10px}.icon-claims-study{background-position:-882px -10px}.icon-claims-books{background-position:-924px -10px}.icon-claims-blank{background-position:-10000px -10000px}[class^="icon-claims-ct-"],[class*=" icon-claims-ct"]{background-image:url("images/0016-0412_icon-claims.png");background-position:14px 14px;background-repeat:no-repeat;display:inline-block;height:32px;line-height:18px;vertical-align:middle;width:32px}.icon-claims-ct-apartment{background-position:-2px 7px}.icon-claims-ct-entertainment{background-position:-44px 7px}.icon-claims-ct-taxi{background-position:-86px 7px}.icon-claims-ct-travel{background-position:-128px 7px}.icon-claims-ct-accommodation{background-position:-170px 7px}.icon-claims-ct-overseas{background-position:-212px 7px}.icon-claims-ct-airport{background-position:-254px 7px}.icon-claims-ct-mobile{background-position:-296px 7px}.icon-claims-ct-car{background-position:-338px 7px}.icon-claims-ct-laundry{background-position:-380px 7px}.icon-claims-ct-drinks{background-position:-422px 7px}.icon-claims-ct-gift{background-position:-464px 7px}.icon-claims-ct-break{background-position:-506px 7px}.icon-claims-breakfast{background-position:-548px 7px}.icon-claims-ct-lunch{background-position:-590px 7px}.icon-claims-ct-dinner{background-position:-632px 7px}.icon-claims-ct-technology{background-position:-674px 7px}.icon-claims-ct-hotel{background-position:-716px 7px}.icon-claims-ct-telephone{background-position:-758px 7px}.icon-claims-ct-medical{background-position:-800px 7px}.icon-claims-ct-dental{background-position:-842px 7px}.icon-claims-ct-study{background-position:-884px 7px}.icon-claims-ct-books{background-position:-926px 7px}.icon-claims-ct-blank{background-position:-10000px -10000px}[class^="icon-claims-status-"],[class*=" icon-claims-status-"]{background-image:url("images/0016_0412_Approved_Reject_Override_Icon.png");background-position:14px 14px;background-repeat:no-repeat;display:inline-block;height:18px;line-height:18px;vertical-align:text-top;width:62px}.icon-claims-status-accept{background-position:-10px -10px}.icon-claims-status-reject{background-position:-80px -10px}.icon-claims-status-override{background-position:-150px -10px}section.list-view-item header.claims-pending h4{text-shadow:none}section.list-view-item header.claims-accept h4{color:#71c671;text-shadow:none}section.list-view-item header.claims-reject h4{color:#d41e2a;text-shadow:none}section.list-view-item header.claims-override h4{color:#d6b602;text-shadow:none}[class^="icon-gts-filttype-"],[class*=" icon-gts-filttype-"]{background-image:url("images/0016_0412_file-type.png");background-position:14px 14px;background-repeat:no-repeat;display:inline-block;height:32px;line-height:32px;vertical-align:text-top;width:32px}.icon-gts-filttype-ppt{background-position:-10px -10px}.icon-gts-filttype-word{background-position:-52px -10px}.icon-gts-filttype-excel{background-position:-94px -10px}.icon-gts-filttype-pdf{background-position:-136px -10px}.icon-gts-filttype-form16{background-position:-178px -10px}.icon-gts-filttype-pslip{background-position:-220px -10px}.icon-gts-filttype-claims{background-position:-262px -10px}[class^="icn-gts-xsmall-"],[class*=" icn-gts-xsmall-"]{background-repeat:no-repeat;display:inline-block;height:16px;line-height:16px;vertical-align:text-top;width:16px}.icn-gts-xsmall-star-shaded{background-image:url("images/star-shaded-xsmall.jpg")}.icn-gts-xsmall-star-bright{background-image:url("images/star-bright-xsmall.jpg")}.page-title{position:relative}.no-margin-t{margin-top:0}.no-margin-r{margin-right:0}.no-margin-b{margin-bottom:0}.no-margin-l{margin-left:0}.no-margin{margin-top:0;margin-right:0;margin-bottom:0;margin-left:0}.no-text-wrap{white-space:nowrap}.month-wise-view .fixed-view{width:230px}.month-wise-view .fixed-view .month{min-width:60px}.month-wise-view .fixed-view .item{max-width:130px;width:130px;overflow:hidden;white-space:nowrap}.month-wise-view .fixed-view .total{max-width:80px;width:80px;overflow:hidden;white-space:nowrap}.month-wise-view .scrollable-view{width:510px}.month-wise-view .scrollable-view.wider{width:685px}.gts-daterangeselector{display:inline;position:relative}.gts-daterangeselector input.gtsdrs-view{background-color:#fff;border:1px solid #c9d7e0;border-radius:3px 3px 3px 3px;cursor:default;display:inline-block;padding-right:20px}.gts-daterangeselector i.gtsdrs-ctrl-dd{position:absolute;right:8px;top:-1px;margin-top:-2px;cursor:pointer}.gts-daterangeselector .gtsdrs-dropdown{position:absolute;border:1px solid #c9d7e0;border-radius:3px 3px 3px 3px;width:100%;min-width:450px;top:23px;z-index:100}.gts-daterangeselector .gtsdrs-dropdown .gtsdrs-dd-wrapper{background:#fff;padding:15px 10px 10px}.gts-daterangeselector .gtsdrs-dropdown .gtsdrs-dd-wrapper .item-label{line-height:28px;text-align:right}.gts-daterangeselector .gtsdrs-dropdown .gtsdrs-dd-wrapper .gtsdrs-actions{text-align:center}.gts-daterangeselector .gtsdrs-dropdown .gtsdrs-dd-wrapper .gtsdrs-actions .btn{margin-right:5px}.gts-daterangeselector .gtsdrs-dropdown .gtsdrs-dd-wrapper .error{color:#b94a48}input.claim-select-excel{border:0;width:90%;margin:-3px}input.claim-input-excel{border:0;width:100%;margin:-3px -4px}input.claim-input-excel-80{border:0;width:80%;margin:-3px -4px}input.claim-input-detailed-excel{border:0;width:60%;margin:-3px -4px}input.claim-attachment-detail-excel{margin:-3px -4px}textarea.claim-text-detailed-excel{margin:-3px -4px}input.claim-amountfield{text-align:right}label.claim-label-excel{font-size:.85em;margin-left:-4px;margin-top:10px}button.claim-button-excel{padding:0}table.claim-row-item{border-width:1px 1px 1px 0;border-style:solid solid solid none}table.claim-row-item td.row-item-cell{padding:0}table.claim-item{border-collapse:collapse;border-width:0;border-style:none}tr.claim-item-verified{background-color:#c7f7c7;margin:3px 5px 3px 0}.smaller{font-size:.70em}.gts-calendar{width:100%}.gts-calendar .cal-top-bar{font-weight:bold;padding-bottom:5px;text-align:center}.gts-calendar .cal-top-bar .cal-title{padding-top:4px;font-size:1.2em}.gts-calendar .cal-top-bar .prev{float:left}.gts-calendar .cal-top-bar .next{float:right}.gts-calendar .cal-table{table-layout:fixed;width:100%}.gts-calendar .cal-table .tbl-title,.gts-calendar .cal-table .tbl-day{border:1px solid #CCC;text-align:center;width:14.27%}.gts-calendar .cal-table .tbl-title{font-weight:bold;padding:3px}.gts-calendar .cal-table .tbl-day{padding:0;overflow:hidden;vertical-align:top;user-select:none;-moz-user-select:none;-khtml-user-select:none}.gts-calendar .cal-table .tbl-day.prev,.gts-calendar .cal-table .tbl-day.next{opacity:.5}.gts-calendar .cal-table .tbl-day.active{border:1px solid blue}.gts-calendar .cal-table .tbl-day-content{height:100%;overflow:hidden;position:relative}.gts-calendar .cal-table .tbl-day-content.default-view{display:table-cell;vertical-align:middle}.gts-calendar .cal-table .tbl-day-content.custom-view{text-align:left;position:relative}.gts-calendar .cal-table .brdr-b-hide{border-bottom:0}.gts-calendar .cal-table .brdr-r-hide{border-right:0}.emp-muster-view .musterInfoTable td,.emp-muster-view .musterInfoTable th{font-size:8.5px;border:0}.emp-muster-view .musterInfoTable td.hightlight.current{border-style:none!important}.emp-muster-view .employeeInfoTable td,.emp-muster-view .employeeInfoTable th{border:0}.emp-muster-view .hightlight{border-width:1px!important;border-color:blue!important;border-top-style:none;border-bottom-style:none;border-right-style:solid!important;border-left-style:solid!important}.emp-muster-view .rowHightlight td{border-width:1px;border-color:blue;border-top-style:solid!important;border-bottom-style:solid!important;border-right-style:none;border-left-style:none}.emp-muster-view td.status1-data{border-right-style:none!important;padding-right:0}.emp-muster-view td.status2-data{border-left-style:none!important;padding-left:0}.emp-muster-view td.status-data{padding:3px 6px}.emp-muster-view .table-info th{background-color:#cde3f2}.emp-muster-view .musterInfo_header th{width:15px}.emp-muster-view .musterInfo_header th.summary{width:105px}.att-status-p .fg,.att-status-p.fg{color:#005e19}.att-status-p .bg,.att-status-p.bg{background-color:#d9fcea}.att-status-l .fg,.att-status-l.fg{color:#023d68}.att-status-l .bg,.att-status-l.bg{background-color:#c2ebfc}.att-status-h .fg,.att-status-h.fg{color:#420268}.att-status-h .bg,.att-status-h.bg{background-color:#f5d9fc}.att-status-r .fg,.att-status-r.fg{color:#6d6d6d}.att-status-r .bg,.att-status-r.bg{background-color:#d9dadb}.att-status-a .fg,.att-status-a.fg{color:#890207}.att-status-a .bg,.att-status-a.bg{background-color:#fcd9db}.att-status-od .fg,.att-status-od.fg{color:#005e19}.att-status-od .bg,.att-status-od.bg{background-color:#d9fcf5}.att-status-ps .fg,.att-status-ps.fg{color:#d64c02}.att-status-ps .bg,.att-status-ps.bg{background-color:#fcd2c2}.att-status-off .fg,.att-status-off.fg{color:#6d6d6d}.att-status-off .bg,.att-status-off.bg{background-color:#d9dadb}.att-status-rh .fg,.att-status-rh.fg{color:#8b4513}.att-status-rh .bg,.att-status-rh.bg{background-color:#deb887}[class^="att-daytype-icon-"],[class*=" att-daytype-icon-"]{display:inline-block;width:18px;height:18px;margin-top:1px;line-height:18px;vertical-align:text-top;background-image:url(images/att-day-type-18x18.png);background-position:-10000px -10000px;background-repeat:no-repeat}.att-daytype-icon-regular{background-position:-10000px 0}.att-daytype-icon-restday{background-position:-1px 0}.att-daytype-icon-offday{background-position:-29px 0}.att-daytype-icon-holiday{background-position:-57px 0}.att-daytype-icon-halfday{background-position:-85px 0}.att-daytype-icon-psd{background-position:-113px 0}.att-daytype-icon-isoverride{background-position:-168px 0}.att-daytype-icon-isregularized{background-position:-142px 0}.gts-dashboard .ds-header .ds-btn{margin-left:5px}.gts-dashboard .gts-ds-body{margin-top:5px}.gts-dashboard .gts-ds-body.ds-body-enabled.ds-body-edit-suspend .row-fluid .db-dashlet{cursor:default}.gts-dashboard .db-row{margin-bottom:10px}.gts-dashboard .row-fluid .db-dashlet{display:block}.gts-dashboard .row-fluid .db-dropspot{min-height:150px;border:1px solid #EEE}.gts-dashboard .row-fluid .db-dropspot.empty{border:0;box-shadow:none}.gts-dashboard .row-fluid .db-dropspot.empty .db-dashlet{background-color:none;background-image:none}.gts-dashboard .row-fluid .db-dashlet{background-color:#FFF;display:block;padding:5px}.gts-dashboard .ds-body-enabled .row-fluid .db-dashlet{cursor:move}.gts-dashboard .ds-body-enabled .row-fluid .db-dropspot.empty{border:1px dotted lightblue}.gts-dashboard .ds-body-enabled .row-fluid .db-drop-active.db-dropspot{border:1px dotted green}.gts-dashboard .ds-body-enabled .row-fluid .db-droppable{border:1px dashed red!important}.gts-dashboard .ds-body-enabled .ds-dashlet-header .ds-dashlet-help,.gts-dashboard .ds-body-enabled .ds-dashlet-header .ds-dashlet-option{display:block}.gts-dashboard .db-row-ghost .db-dropspot{min-height:50px;overflow:hidden}.gts-dashboard .ds-dashlet-header{padding:5px;line-height:15px;font-weight:bold;color:#227cba;font-size:1.15em}.gts-dashboard .ds-dashlet-header i{margin-left:4px;cursor:pointer}.gts-dashboard .ds-dashlet-header .ds-dashlet-help{display:none}.gts-dashboard .ds-dashlet-header .ds-dashlet-option{display:none}.gts-dashboard .ds-dashlet-header:hover .ds-dashlet-help,.gts-dashboard .ds-dashlet-header:hover .ds-dashlet-option{display:block}.gts-dashboard .ds-dashlet-body{padding:0 0 5px 0;margin-bottom:0}.gts-dashboard .db-drag-helper{background:#d2e6f0;background:rgba(210,230,240,0.7);filter:alpha(opacity = 70);opacity:.7}.gts-dashboard .dashlet-nodata{background:#d3d3d3;background:rgba(211,211,211,0.4)}.gts-dashboard .dashlet-nodata-inner{font-weight:bold;padding-top:17%;text-align:center}.cheatsheet{font-size:11px}.cheatsheet .cheat-accordion .user-actions{padding-top:10px}.cheatsheet .cheat-accordion .user-actions li{padding-left:1.7em;position:relative}.cheatsheet .cheat-accordion .user-actions li span{cursor:pointer;text-decoration:underline}.cheatsheet .cheat-accordion .user-actions li span.ui-icon{background-image:url(jquery/images/ui-icons_217bc0_256x240.png);position:absolute;left:.1em}.cheatsheet .cheat-accordion ul.actions{width:49%;float:left}.cheatsheet .cheat-accordion ul.help-actions{width:49%;float:right}.cheatsheet .cheat-accordion h3.ui-accordion-header .help{cursor:pointer;left:auto;right:.5em}.cheatsheet .cheat-accordion h3.ui-accordion-header a{padding-right:2.2em}.cheatsheet .cheat-accordion h3.ui-accordion-header .status-active{border:1px solid blue}.cheatsheet .cheat-accordion h3.status-done a{background-color:lightBlue;text-decoration:line-through}.cheatsheet .cheat-accordion h3.status-done span.ui-icon-triangle-1-e,.cheatsheet .cheat-accordion h3.status-done span.ui-icon-triangle-1-s{background-position:-64px -144px}.cheatsheet .cheat-accordion h3.status-done span.ui-icon-help{background-position:-48px -144px}.cheatsheet .cheat-accordion h3.status-skip a{background-color:lightBlue;text-decoration:line-through}.cheatsheet .cheat-accordion h3.status-skip span.ui-icon-triangle-1-e,.cheatsheet .cheat-accordion h3.status-skip span.ui-icon-triangle-1-s{background-position:-32px -64px}.cheatsheet .cheat-accordion h3.status-skip span.ui-icon-help{background-position:-48px -144px}.cheatsheet .cheat-accordion h3.status-todo a{background-color:lightgrey}.cheatsheet .cheat-location{padding-bottom:10px;padding-left:10px}.cheatsheet .cheat-location span.cheat-parent{text-decoration:underline;cursor:pointer}.cheatsheet .cheat-mask{background-color:white;opacity:.5;filter:alpha(opacity = 50);position:absolute;z-index:999}.cheatsheet .extra-status{padding-left:1.7em;padding-top:5px;position:relative}.cheatsheet .extra-status span.ui-icon{background-image:url(jquery/images/ui-icons_217bc0_256x240.png);position:absolute;left:.1em}.cheatsheet .extra-status .extra-status-desc{font-weight:bold}.cheatsheet .card-location div.cheat-parent{padding:0 3px 7px;-moz-border-radius:5px;-webkit-border-radius:5px}.cheatsheet .card-location div.cheat-parent .parent-desc{cursor:pointer;color:black;font-size:1.1em;padding:5px;overflow:hidden}.cheatsheet .card-location div.cheat-parent .parent-desc .step{float:right}.cheatsheet .card-location div.cheat-parent .parent-desc .caption{text-decoration:underline}.cheatsheet .card-location div.cheat-parent .parent-desc .display-order{font-weight:bold;padding-right:10px}.cheatsheet .card-location div.cheat-parent div.parent-wrapper{padding-left:7px}.cheatsheet .card-location div.cheat-parent-current{padding-bottom:5px}.cheatsheet .card-location div.cheat-parent-current div.parent-wrapper{padding-left:0}.cheatsheet .card-location div.location-0{background-color:#8fbddb}.cheatsheet .card-location div.location-1{background-color:#dbb085}.cheatsheet .card-location div.location-2{background-color:#d9dbb8}.cheatsheet .card-location div.location-3{background-color:#8fbddb}.gt-cheatsheet-floater{background:orange none repeat scroll 0 0;-moz-border-radius:4px;-webkit-border-radius:4px;border:1px solid black;position:absolute;top:95px;right:1px;overflow:hidden;color:white;z-index:100;font-size:11px}.gt-cheatsheet-floater .handler{float:left;padding-top:1px;width:18px}.gt-cheatsheet-floater .handler .close-hanlder,.gt-cheatsheet-floater .handler .open-hanlder{cursor:pointer;padding:40px 3px 0;font-size:1.2em;font-weight:bold;color:black}.gt-cheatsheet-floater .handler .close-hanlder{background:transparent url(images/cheatsheet/right-open.gif) no-repeat scroll 0 0}.gt-cheatsheet-floater .handler .open-hanlder{background:transparent url(images/cheatsheet/left-open.gif) no-repeat scroll 0 0}.gt-cheatsheet-floater .handler .desc-part{padding-bottom:8px}.gt-cheatsheet-floater .float-body{float:left;background-color:#cffbff}.gt-cheatsheet-floater .float-cheatsheet-wrapper{padding:0 4px}.gt-cheatsheet-floater .float-cheatsheet-ct{overflow:hidden;padding:5px 0;min-height:191px}.gt-cheatsheet-floater .dataTables_wrapper{min-height:0}.gt-cheatsheet-floater .cheat-location{color:black}.gt-cheatsheet-floater .cheatsheet .cheat-accordion h3 .status-done a{background-color:#e0ebef}.gt-cheatsheet-floater .cheatsheet .cheat-accordion h3 .status-skip a{background-color:#e0ebef}.gt-cheatsheet-floater .cheatsheet .cheat-accordion h3 .status-todo a{background-color:#dfdfdf}.label-left .control-label{text-align:left}.xxsmall-labels .control-label{width:60px!important;text-align:left}.xxsmall-labels .controls{margin-left:70px}.small-labels .control-label{width:100px!important;text-align:left}.small-labels .controls{margin-left:110px}.xxlarge-labels .control-label{width:275px!important;text-align:left;font-weight:bold}.xxlarge-labels .controls{margin-left:285px}.option_page .section{border-bottom:1px solid #efefef}.option_page legend{font-size:14px;font-weight:bold;line-height:25px}.option_page fieldset>div{margin-left:15px}.option_page .xxlarge-labels .control-label{font-weight:normal}.option_page h4{margin:20px 0 5px 0;border-bottom:1px dotted #cdcdcd}.option_page .checkbox-set .control-group{margin-bottom:5px}.ui-footer-inner{background-color:#eee;margin-top:25px;padding:10px 20px}.mini-question{background:url(images/question_mark_over.gif) no-repeat center center;width:13px;height:14px;display:inline-block;vertical-align:middle}i.small-cross{font-size:.9em;color:#8e1702;font-style:normal}.ess-templates .nav-list{min-height:400px}.ess-templates .nav-list>li>a{padding:5px 15px}.ess-templates .gt-canvas{box-sizing:border-box;width:100%;padding:5px;background-color:#f8efff}.ess-templates .gt-row{box-sizing:border-box;background-color:#effff1;padding:3px 20px;height:42px;clear:both;margin-top:15px}.ess-templates .gt-col-container{box-sizing:border-box;width:47%;float:left;background-color:#9bc9a2;padding:5px;margin:3px 5px}.ess-templates .gt-layout-container{width:150px;background-color:#9bc9a2;padding:5px;margin:3px 5px 3px 20px}.ess-templates .gt-field-list{margin-top:10px;padding:10px 4px 0 15px;min-height:500px}.ess-templates .gt-field-list .gt-field-item{margin-bottom:10px}.ess-templates .gt-field-list.drop-hover{background-color:#d9e9fc}.ess-templates .gt-field-list .gt-col:hover{border:1px solid #a88b35}.ess-templates .gt-field-list li{list-style-type:none}.ess-templates .templates{border-right:1px solid #9e9e9e}.ess-templates .fields{border-left:1px solid #9e9e9e}.ess-templates .fields-group{border-right:1px solid #9e9e9e}.gt-col{height:18px;padding:3px;cursor:move;overflow:hidden;background-color:#fff0c6;border:1px dashed #a88b35}.gt-col:hover{border:1px solid #a88b35;background-color:#ffe393}.gt-col label{width:250px;height:14px;line-height:15px;display:block;overflow:hidden;float:left;cursor:move;font-size:.9em;padding-top:2px;text-overflow:ellipsis;white-space:nowrap}.gt-col .gt-filler{background:rgba(53,94,132,0.7);color:white;border:1px solid #4a4a4a;line-height:.9em;font-size:.9em;margin-left:5px;width:70px;display:inline-block}.gt-col .gt-filler:after{content:'XXXXXXXXX'}.category-desc{border-bottom:1px solid #d4e3fc;padding-bottom:15px}.well2{background-color:#f5f5f5;border:1px solid #e3e3e3;border-radius:4px 4px 4px 4px;box-shadow:0 1px 1px rgba(0,0,0,0.05) inset;margin-bottom:5px;min-height:25px;padding:10px}.well2 h3,.well2 h4{margin-top:0;margin-bottom:5px}.bold{font-weight:bold}.btn-icon{cursor:pointer;margin-right:10px}.secondary{color:#666}.text-center{text-align:center}.ngCellElement input{-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;white-space:nowrap;height:25px;border-radius:0;border:1px solid #9d9d9d;margin-right:5px;padding:3px}.ngGrid .ngDirty{color:#0474d6}.ngGrid .ngDelete .ngCellText span{text-decoration:line-through;color:#9e9e9e!important}.ngGrid .ngInvalid{color:#e20413}.ngGrid .ng-serial-no{text-align:right;padding-right:10px}.ngGrid .ng-serial-no:after{content:'.'}.ng-cell-button{padding:2px 0}.ng-cell-button i{cursor:pointer;margin:0 5px}.ngCell select{outline:0;border-radius:0;border:1px solid #9d9d9d;width:100%}.vtabs{margin-top:10px;list-style:none;margin-left:0}.vtab{margin:5px 0 5px 0;cursor:pointer;position:relative;z-index:99;border-radius:5px 0 0 5px;background-color:#f6f6f6}.vtab.active{background-color:#eff5f7;margin-right:-2px;padding-right:2px}.vtab>div{padding:8px;border:1px solid #aeaeae;border-right:0;border-radius:5px 0 0 5px}.vtab.active>div{border:1px solid #abcde8;border-right:0}.vtab2{margin-right:-2px}.vtab2.active{margin-right:-5px}.vtab-edit{cursor:default}.vtab-content{background-color:#eff5f7;padding:8px;border:1px solid #abcde8;border-radius:5px}.vtab-content table{background-color:transparent}.pagelist{display:inline-block;margin:0 0 3px 0}ul.pagetabs{list-style-type:none;display:inline-block;margin:0 30px 0 0;padding:0;vertical-align:bottom;height:33px}.pagetabs li{display:inline-block;padding:6px;font-size:1.3em;text-align:center;width:20px;height:20px;border:1px solid #0f74a2;border-bottom:0;background-color:#fafafa;margin:0 2px 0 2px;cursor:pointer;outline:0}.pagetabs li.active{background-color:#eff5f7;margin-bottom:-2px}.pageset .header{line-height:25 px;background-color:#eff5f7;padding:0;margin-right:20px}.pageset .footer{line-height:25 px;border-bottom:1px solid #0f74a2;background-color:#eff5f7;padding:5px 3px;margin-right:20px}.pageset .pagecount{display:inline-block;padding:6px;font-size:1.3em;text-align:center;width:50px;background-color:#fafafa;margin:0 2px 0 2px}.pageset h4{padding:10px 0}.wizsteps{width:98%;margin:0 5px}.wizsteps ul{list-style-type:none;display:table;overflow:hidden;width:98%;margin:0 20px 0 10px}.wizsteps li{display:inline-block;text-transform:uppercase;margin:0;padding:0;font-size:.85em;color:#3472af;min-width:130px;text-align:center;display:table-cell}.wizsteps .step-desc{padding:0 20px 5px 20px;text-align:center;font-size:.95em}.wizsteps li.final{margin-left:-4px}.wizsteps .step-indicator{height:20px;border-bottom:2px solid #cdcdcd;margin-bottom:15px}.wizsteps .step-circle-outer{border:2px solid #cdcdcd;border-radius:12px;height:16px;width:16px;background-color:#efefef;position:relative;top:12px;margin:0 auto}.wizsteps .current .step-circle-outer{background-color:#03a503}.wizsteps .prev .step-circle-outer{background-color:#b6efb6}.wizsteps .current{font-weight:bold}.action-list p.action-name{width:250px;white-space:nowrap;-ms-text-overflow:ellipsis;-o-text-overflow:ellipsis;text-overflow:ellipsis;overflow:hidden;line-height:20px;padding:3px 0}.action-list .fav{display:inline-block;cursor:pointer;color:#afafaf}.action-list .fav.active{color:#eaae09}.left-col{padding-right:15px}.right-col{padding-left:15px}.action-list h4{margin:15px 0 10px 0;border-bottom:1px solid #abcde8}.trans-type{display:inline-block;margin-left:5px}.gt-trans-select .trans-value{display:inline-block;min-width:250px}.trans-values{min-width:250px}.gt-trans-multi-select table.trans-value{width:100%;height:100%;min-height:125px}.gt-trans-multi-select .value-selector{width:48%;height:100%;min-height:125px}.gt-trans-multi-select .value-selector .trans-values{margin-bottom:0;width:100%;height:100%}.gt-trans-multi-select .value-selector .trans-values option{padding:5px}.gt-trans-multi-select .value-move{padding:0 5px;width:4%;text-align:center}.gt-trans-multi-select .value-move i{cursor:pointer}.gt-trans-multi-select .selected-values{vertical-align:top;height:100%}.gt-trans-multi-select .selected-values>div{border:1px solid #c9d7e0;border-radius:4px;height:100%}.gt-trans-multi-select .selected-values .values{overflow-y:auto}.gt-trans-multi-select .selected-values .trans-value{display:inline-block;margin:3px;padding:3px;border:1px solid #dedede;color:#666;line-height:15px;font-size:.95em;background-color:#d0d2e5}.gt-trans-multi-select .selected-values .trans-value i.close{margin:0 0 0 10px;font-size:.9em;line-height:10px;padding:2px}.gt-trans-multi-select .selected-values .trans-value.type-location{background-color:#baeeff}.gt-trans-multi-select .selected-values .trans-value.type-designation{background-color:#ffd3e6}.gt-trans-multi-select .selected-values .trans-value.type-company{background-color:#ffcb91}.gt-trans-multi-select .selected-values .trans-value.type-department{background-color:#d5f4d2}.gt-trans-multi-select .selected-values .trans-value.type-grade{background-color:#e0c6ff}.gt-file-upload{display:inline-block;padding-top:5px}.gt-file-upload .gt-file-upload-add-file+input{display:none}.gt-file-upload-ie-input-hack .gt-file-upload-add-file{display:none}.gt-file-upload-ie-input-hack .gt-file-upload-add-file.hidden+input{display:none}.gt-file-upload-ie-input-hack .gt-file-upload-add-file+input{display:inline-block}.ie9 .gt-file-upload-add-file{display:none}.ie9 .gt-file-upload-add-file.hidden+input{display:none}.ie9 .gt-file-upload-add-file+input{display:inline-block}.ie10 .gt-file-upload-add-file{display:none}.ie10 .gt-file-upload-add-file.hidden+input{display:none}.ie10 .gt-file-upload-add-file+input{display:inline-block}[class^="poi-status-icon-"],[class*=" poi-status-icon-"]{display:inline-block;width:18px;height:18px;margin-top:1px;line-height:18px;vertical-align:text-top;background-image:url(images/POI_ICONSprite.png);background-position:-10000px -10000px;background-repeat:no-repeat}.logo-outer{padding:3px;border:1px solid #aeaeae;margin:0 10px 10px 0;background-color:#efefef}.logo-outer.logo-medium{width:210px;height:70px}.logo-outer.logo-small{width:180px;height:45px}.poi-status-icon-pending{background-position:-3px -67px}.poi-status-icon-approved{background-position:-4px -46px}.poi-status-icon-rejected{background-position:-3px -27px}.poi-status-icon-draft{background-position:-4px -5px}.poi-status-icon-overriden{background-position:-3px -89px}.file-holder .file{height:22px;margin-bottom:5px;font-size:.9em;color:#404040}.file-holder .file span{padding:3px;border:1px solid #dcdcdc;background-color:#fafafa;border-radius:4px}.rollup{height:100px;overflow-y:hidden}.overlay{background-color:#fff;display:block;position:absolute;overflow:auto;margin:auto;top:0;left:0;bottom:0;right:0;float:none;z-index:995;zoom:1;filter:alpha(opacity=50);opacity:.5}.loader{background-color:#39363f;color:#fff;width:150px;height:40px;position:absolute;z-index:999;overflow:auto;margin:auto;top:0;left:0;right:0;border:1px solid #6b6576;box-shadow:5px 5px 24px 2px rgba(16,66,71,0.41)}.loader .inner{text-align:center;margin-top:10px}.clear-demo-loader{background-color:#ffe9cc;color:#333;width:250px;height:60px;position:absolute;z-index:999;overflow:auto;margin:auto;top:0;left:0;right:0;bottom:0;border:1px solid #ffbc66;box-shadow:5px 5px 24px 2px rgba(16,66,71,0.41)}.clear-demo-loader .inner{text-align:center;margin-top:20px}.grid-overlay{background-color:rgba(128,128,128,0.2);z-index:999;position:absolute;width:100%;height:100%}.grid-overlay.loader{background-color:#ffe9cc;color:#333;margin:auto;overflow:auto;top:0;left:0;bottom:0;right:0;width:150px;height:50px;position:absolute;z-index:999;border:1px solid #ffbc66;box-shadow:5px 5px 24px 2px rgba(16,66,71,0.41)}.gts-grid{position:relative}.transition-height{height:250px!important;overflow-y:hidden}.rollup-divider{width:100%;height:10px;background-color:#e8f1f4;border-bottom:1px solid #a4d5ea;margin-top:5px;cursor:n-resize}.no-margin-below{margin-bottom:0!important}@media print{*{background:transparent!important;color:#000!important;box-shadow:none!important;text-shadow:none!important}a,a:visited{text-decoration:underline}a[href]:after{content:" (" attr(href) ")"}abbr[title]:after{content:" (" attr(title) ")"}a[href^="javascript:"]:after,a[href^="#"]:after{content:""}pre,blockquote{border:1px solid #999;page-break-inside:avoid}thead{display:table-header-group}tr,img{page-break-inside:avoid}img{max-width:100%!important}p,h2,h3{orphans:3;widows:3}h2,h3{page-break-after:avoid}.no-print{display:none!important;font-size:24px!important;text-align:center}.container2{box-shadow:none;border-bottom:0}.masthead{margin-top:0}.page-title{text-align:center}.page-title h2{font-size:18px}}@media screen{.only-print{display:none!important}}@media(min-width:1200px){.scrollable{width:1080px}.month-wise-view .scrollable-view{width:700px}.month-wise-view .scrollable-view.wider{width:915px}}@media(max-width:1024px){#gts-bounce-nav .navbar-inner .nav>li>a{padding:10px 10px 9px}#gts-bounce-nav .navbar-inner .nav>li i{display:none}#gts-bounce-nav .navbar-inner .right-menu>li i{display:inline}.gt-sidenav .nav-item.level2 a{padding-left:5px}.report-block{width:47%}}@media(max-width:767px){.scrollable{width:620px}.gts-nav-flat-dropdown-menu>table td .gts-nav-col{width:140px}.gts-nav-flat-dropdown-menu>table td .gts-nav-col>section>ul{overflow-x:hidden}}@media(min-width:768px) and (max-width:979px){.scrollable{width:640px}.gts-nav-flat-dropdown-menu>table td .gts-nav-col{width:170px}.gts-nav-flat-dropdown-menu>table td .gts-nav-col>section>ul{overflow-x:hidden}.month-wise-view .scrollable-view{width:330px}.month-wise-view .scrollable-view.wider{width:470px}}.panel-container{margin-right:5px;padding:10px}.panel-container .photo-container{margin:0 20px 20px 0;width:150px;height:150px;text-align:center;float:left}.panel-container .user-photo{width:128px;height:128px;padding:3px;border:1px solid #aeaeae;background-color:#efefef}.panel-container i{cursor:pointer;color:#b3b3b3}.panel-container i:hover{color:#333}.panel-container .panel{background-color:#fff;margin-bottom:20px;padding:5px 10px 30px 10px;border:2px solid #e0e0e0}.panel-container h3{color:#a8a8a8;padding-bottom:10px}.panel-container label{color:#595959}.panel-container .panel-1{border-top:4px solid #ec0606}.panel-container .panel-2{border-top:4px solid #0476e0}.panel-container .panel-3{border-top:4px solid #03b238}.panel-container .panel-4{border-top:4px solid #e5d202}.panel-container .panel-5{border-top:4px solid #e58404}.panel-container .panel-6{border-top:4px solid #8003aa}.panel-container .controls.active{background-color:#e0f5fc}.panel-container .controls.ngGhost{color:#4d4d4d}.panel-container .letter-template-panel{width:45%;float:left;margin-right:20px}.panel-container .panel-body{min-height:100px}.modal-wide{width:75%}.letter-fields,.datasource-fields{height:500px;overflow-y:scroll;border:1px solid #cecece;border-radius:3px}.letter-field{display:inline-block;width:95%;cursor:pointer;padding:5px}.letter-field:hover{background-color:#39f;color:white}.data-row{clear:both;margin:5px 0 5px 0;padding:5px 0}.data-row label{float:left;width:160px;margin-right:10px;text-align:right}.data-row label.large{width:180px}.gt-controls input[type="radio"],.gt-controls input[type="checkbox"]{margin:0}.gt-controls .radio-text,.gt-controls .checkbox-text{vertical-align:middle;display:inline-block}.gt-filter-criteria-ct{display:inline-block}.criteria-container .criteria-group{padding:5px;background-color:#f7f0ea;border:1px solid #e8d4c2;border-radius:5px}.criteria-container .criteria{padding:5px;background-color:#eaf9f9;border:1px solid #ceeaea;border-radius:5px}.criteria-container .criteria input{padding-top:4px;margin:4px 0}.criteria-container .criteria select,.criteria-container .criteria .select2-container{font-size:.9em;margin:4px 0;vertical-align:middle}.criteria-container .first{margin-top:10px}.criteria-container .last{margin-bottom:10px}.criteria-container .criteria-connector,.criteria-container .group-connector{font-size:11px;font-weight:bold;text-transform:uppercase;width:100px;padding:3px;text-align:center;cursor:pointer}.criteria-container .criteria-connector{background-color:#eaf9f9;border:1px solid #ceeaea;border-top:0;border-bottom:0;margin-top:-2px}.criteria-container .new{border-radius:0 0 4px 4px}.criteria-container .criteria-connector.new{border-bottom:1px solid #ceeaea}.criteria-container .group-connector{background-color:#f7f0ea;border:1px solid #e8d4c2;border-top:0;border-bottom:0;margin:0 auto;margin-top:-2px}.criteria-container .group-connector.new{border-bottom:1px solid #e8d4c2}.orgchart svg{overflow:hidden}.orgchart rect{fill:#e3f4f0;stroke:#8fb7ac;pointer-events:all;overflow:hidden}.orgchart rect.parent{cursor:pointer}.orgchart rect.leaf{fill:#e3f9c5;stroke:#b5ce94}.orgchart text{font-family:"Helvetica Neue",Helvetica,sans-serif}.orgchart .name,.orgchart .empNo{font-weight:500;font-size:1em;pointer-events:none;border:1px solid #cecece;padding:0;width:50px;overflow:hidden}.orgchart .name.active,.orgchart .empNo.active{font-size:1.3em}.orgchart .about{fill:#777;font-size:smaller}.orgchart .node{font:10px sans-serif}.orgchart .node circle{fill:#f0f8ff;stroke:#4682b4;stroke-width:1px;pointer-events:all}.orgchart .node{font:10px sans-serif}.orgchart .link{fill:none;stroke:#ccc;stroke-width:1.5px}.indent{padding-left:10px}.indent0{padding-left:5px}.indent1{padding-left:15px}.indent2{padding-left:25px}.indent3{padding-left:35px}.indent4{padding-left:45px}.depth0{font-size:1.25em}.depth1{font-size:1.15em}.depth2{font-size:1em}.depth3{font-size:.95em}.depth4{font-size:.95em;font-stle:italic}.override{color:#7c1e99!important}.node-button{display:inline-block;line-height:10px;font-size:12px;width:10px;height:10px;padding:0;text-align:center;vertical-align:middle;margin-right:5px}.node-button.expander,.node-button.collapser{border:1px solid #888;cursor:pointer}.select2-container-active .select2-choice,.select2-container-active .select2-choices{border:1px solid #68bcff}.select2-results .select2-highlighted{background:#68bcff;color:#fff}#app-container .page-header{padding-bottom:0;margin:0;border:0}#app-container .page-header .page-title{border-bottom:1px solid #abcde8;margin:0 0 10px 0}#app-container .page-header .page-title h3{margin-bottom:5px;height:25px;line-height:30px}#app-container .page-header .right-block{float:right;height:25px}#app-container .page-header .right-block div{display:inline-block;vertical-align:middle}#app-container .page-header .right-block i{font-size:1.3em;vertical-align:middle}#app-container .page-header .page-help{margin:25px 40px;padding:12px;border:1px solid #dfdfdf;border-left:5px solid #68bcff;color:#4d4d4d;background:#eff5f7 url(images/app-bg.png)}#app-container .page-header .page-help br{margin-bottom:10px}.ng-tree-container{min-height:250px;border:1px solid #cecece;border-radius:4px;overflow-y:scroll;overflow-x:hidden}ul.ng-tree{margin-left:0}ul.ng-tree ul{margin-left:10px}ul.ng-tree li{list-style:none}ul.ng-tree li div{padding-left:3px}ul.ng-tree a{display:block;padding:5px;cursor:pointer;margin-left:15px;color:#333}ul.ng-tree a:hover,ul.ng-tree a:focus{text-decoration:none;background-color:#66b2ff;color:white}ul.ng-tree li.active>div,ul.ng-tree li.active>div>i,ul.ng-tree li.active>div>a{background-color:#39f;color:white}ul.ng-tree i{margin:8px 3px 0 0;cursor:pointer}.accordion-group.ng-enter,.accordion-group.ng-leave{-webkit-transition:all linear .3s;-moz-transition:all linear .3s;-o-transition:all linear .3s;transition:all linear .3s;position:relative}.accordion-group.ng-enter{opacity:.5;left:-50px}.accordion-group.ng-enter.ng-enter-active{opacity:1;left:0}.accordion-group.ng-leave{opacity:1;left:0}.tab-pane.ng-hide-add,.tab-pane.ng-hide-remove{-webkit-transition:all linear .3s;-moz-transition:all linear .3s;-o-transition:all linear .3s;transition:all linear .3s}.tab-pane.ng-hide-remove{opacity:0}.tab-pane.ng-hide-remove.ng-hide-remove-active{opacity:1}.tab-pane.ng-hide-add{opacity:1}.tab-pane.ng-hide-add.ng-hide-add-active{opacity:0}.months-left.ng-enter,.months-left.ng-leave{-webkit-transition:all ease .6s;-moz-transition:all ease .6s;-o-transition:all ease .6s;transition:all ease .6s;position:relative}.months-left.ng-enter{opacity:.5;left:-1000px}.months-left.ng-enter.ng-enter-active{opacity:1;left:0}.months-left.ng-leave{opacity:1;left:0}.months-left.ng-leave.ng-leave-active{opacity:0;left:1000px}.months-left.ng-move{opacity:1;left:0}.months-left.ng-move.ng-move-active{opacity:0;left:1000px}.months-right.ng-enter,.months-right.ng-leave{-webkit-transition:all ease .6s;-moz-transition:all ease .6s;-o-transition:all ease .6s;transition:all ease .6s;position:relative}.months-right.ng-enter{opacity:.5;left:1000px}.months-right.ng-enter.ng-enter-active{opacity:1;left:0}.months-right.ng-leave{opacity:1;left:0}.months-right.ng-leave.ng-leave-active{opacity:0;left:-500px}.fadeout.ng-hide-add,.fadeout.ng-hide-remove{-webkit-transition:all linear .6s;-moz-transition:all linear .6s;-o-transition:all linear .6s;transition:all linear .6s}.fadeout.ng-hide-remove{opacity:0}.fadeout.ng-hide-remove.ng-hide-remove-active{opacity:1}.fadeout.ng-hide-add{opacity:1}.fadeout.ng-hide-add.ng-hide-add-active{opacity:0}.slide-from-top.ng-hide-add,.slide-from-top.ng-hide-remove{-webkit-transition:all ease .3s;-moz-transition:all ease .3s;-o-transition:all ease .3s;transition:all ease .3s;position:relative;display:block!important}.slide-from-top.ng-hide-remove{opacity:.5;top:-50px}.slide-from-top.ng-hide-remove.ng-hide-remove-active{opacity:1;top:0}.slide-from-top.ng-hide-add{opacity:.1;top:0}.slide-from-top.ng-hide-add.ng-hide-add-active{opacity:0;top:-50px}.slide-from-top-1.ng-hide-add,.slide-from-top-1.ng-hide-remove{-webkit-transition:all ease .7s;-moz-transition:all ease .7s;-o-transition:all ease .7s;transition:all ease .7s;position:relative;display:block!important}.slide-from-top-1.ng-hide-remove{opacity:.5;top:-50px}.slide-from-top-1.ng-hide-remove.ng-hide-remove-active{opacity:1;top:0}.slide-from-top-1.ng-hide-add{opacity:.1;top:0}.slide-from-top-1.ng-hide-add.ng-hide-add-active{opacity:0;top:-50px}.slide-from-top-2.ng-hide-add,.slide-from-top-2.ng-hide-remove{-webkit-transition:all ease 1.5s;-moz-transition:all ease 1.5s;-o-transition:all ease 1.5s;transition:all ease 1.5s;position:relative;display:block!important}.slide-from-top-2.ng-hide-remove{opacity:.5;top:-50px}.slide-from-top-2.ng-hide-remove.ng-hide-remove-active{opacity:1;top:0}.slide-from-top-2.ng-hide-add{opacity:.1;top:0}.slide-from-top-2.ng-hide-add.ng-hide-add-active{opacity:0;top:-50px}.gt-sidenav.ng-hide-add,.gt-sidenav.ng-hide-remove{-webkit-transition:all linear 1s;-moz-transition:all linear 1s;-o-transition:all linear 1s;transition:all linear 1s}.gt-sidenav.ng-hide-remove{opacity:0}.gt-sidenav.ng-hide-remove.ng-hide-remove-active{opacity:1}.gt-sidenav.ng-hide-add{opacity:1}.gt-sidenav.ng-hide-add.ng-hide-add-active{opacity:0}.nvd3 .tick text{font:10px Arial}.nvd3.nv-line .nvd3.nv-scatter .nv-groups .nv-point{fill-opacity:1;stroke-opacity:1}.gt-payitem-multi-select{padding:5px}.gt-payitem-multi-select table.selector{width:100%;margin-top:5px}.gt-payitem-multi-select .value-selector{width:40%}.gt-payitem-multi-select .value-selector .values{height:125px;margin-bottom:0;width:100%}.gt-payitem-multi-select .value-move{padding:0 5px;width:15px}.gt-payitem-multi-select .value-move i{cursor:pointer}.gt-payitem-multi-select .selected-values{border:1px solid #c9d7e0;vertical-align:top}.gt-payitem-multi-select .selected-values .values{height:125px;overflow-y:auto;background-color:#FFF}.gt-payitem-multi-select .selected-values .value{display:inline-block;margin:3px;padding:3px;border:1px solid #dedede;color:#666;line-height:15px;font-size:.95em;background-color:#ede8ff}.gt-payitem-multi-select .selected-values .value i.close{margin:0 0 0 10px;font-size:.9em;line-height:10px;padding:2px}.payroll-process-blockui{background-color:rgba(200,200,200,0.5);height:100%;position:fixed;bottom:0;left:0;right:0;top:0;width:100%;z-index:9999}.payroll-process-blockMsg{background-color:#e8f6fc;color:#3a87ad;border:#AAA 1px solid;font-size:1.0em;vertical-align:top;width:400px;padding:10px;margin:0 auto;position:relative;top:50%;height:120px;border-radius:5px;-moz-border-radius:5px;z-index:10000;box-shadow:10px 10px 30px #aeaeae}.payroll-process-blockMsg .background-icon{z-index:-100;color:#cecece;font-size:4em;position:absolute;right:0;margin-right:15px}.payroll-process-blockMsg .message{white-space:nowrap;overflow:hidden;text-overflow:ellipsis}div.loading-indicator{font-size:26px;text-align:center;height:50px;vertical-align:middle;margin-top:20px}.months-outer{width:100%;display:block;text-align:center}.month-nav{display:inline-block;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;cursor:pointer;margin:0;padding:2px 0;vertical-align:top;text-align:center;height:26px;width:2%!important}.month-nav i{margin-top:5px}.month-nav i.inactive,.m-container-outer i.inactive{color:#ccccce;cursor:default}.months{width:7.5%!important;background-color:#d5efef;color:#666;font-size:.85em;border:1px solid #cecece;border-right:0}.months.unlocked{color:#028fff}.months.last{border-right:1px solid #cecece}.months.current{background-color:#daebc1!important;color:#028fff;border:2px solid #028fff;margin-top:-1px}.months.current+div{border-left:none}.months.current.last{border-right:2px solid #0d7ec6!important}.months.new-payroll{background-color:#cfcfcf;color:#666}.months.blank{background-color:#9b9b9b;cursor:default}.m-container-outer{background-color:#eff5f7;border:1px solid #abcde8;min-height:250px;margin:0;padding:0 5px}.m-nav-button{cursor:pointer;display:table;height:330px;width:25px}.m-nav-button i{vertical-align:middle;display:table-cell}.m-container{position:relative;overflow:hidden;height:330px;margin:2px 35px}.m-content{position:absolute;width:100%;height:330px;top:0;left:0}.m-content .header{margin-bottom:20px;border-bottom:1px solid #e0e0e0}.m-content .header-right{margin:10px 5px 10px 0;width:90%;text-align:right}.m-content .new-month{text-align:center;position:absolute;top:50%;width:100%}.control-group .controls>.select2-container[class*="span"]{margin-left:0}.control-group .controls>.gt-remote-select .select2-container[class*="span"]{margin-left:0}.control-group .control-label .dropdown-menu{text-align:left}ul.listbox{width:100%;height:280px;list-type:none;margin:0;padding:0;border:1px solid #cdcdcd;border-radius:4px;overflow-x:hidden;overflow-y:scroll}ul.listbox li{display:block;margin:1px 5px;padding:0;overflow:hidden}ul.listbox li span{padding:5px;width:99%;display:inline-block;-webkit-touch-callout:none;-webkit-user-select:none;-khtml-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none}ul.listbox li span:hover{background-color:#efefef}ul.listbox li span.active{background-color:#39f!important;color:white}ul.listbox li span i{color:#afafaf;margin-right:10px;cursor:pointer}input.date-input{width:90px}.gt-grid-filter{margin-bottom:5px}.gt-grid-filter .lbls{line-height:28px}.gt-grid-filter .gt-grid-filter-date .dropdown-menu{width:180px}.gt-grid-filter-date-range .gt-filter-ctrls>*{vertical-align:top}.gt-grid-filter-date-range .grid-filter-ct{display:inline-block}.gt-grid-filter-date-range .grid-filter-ct.error{color:red}.gt-grid-filter-date-range .grid-filter-ct.error .help-block,.gt-grid-filter-date-range .grid-filter-ct.error .help-inline{color:red}.gt-grid-filter-date-range .grid-filter-ct.error input{border-color:red}.gt-type-select,.gt-trans-select{color:#333;margin:0 4px 0 0;display:inline-block}.gt-type-select .dropdown-toggle,.gt-trans-select .dropdown-toggle{display:inline-block;border:1px solid #cecece;border-radius:4px;color:#333;padding:3px;margin-right:10px;text-decoration:none}.gt-type-select .dropdown-toggle span,.gt-trans-select .dropdown-toggle span{display:inline-block;overflow:hidden;height:18px;line-height:18px;vertical-align:middle;min-width:120px}.gt-type-select .dropdown-toggle .caret,.gt-trans-select .dropdown-toggle .caret{margin:8px 4px 0 6px}.gt-grid-widget{color:#333;font-size:.9em;margin:2px 4px 2px 0;display:inline-block;vertical-align:middle;z-index:950}.gt-grid-widget .dropdown-toggle{display:block;border:1px solid #cecece;border-radius:5px;background-color:#cae9f7;color:#333;padding:3px;text-decoration:none}.gt-grid-widget .dropdown-toggle span{display:inline-block;overflow:hidden;white-space:nowrap;text-overflow:clip "...";max-width:250px;height:18px;line-height:18px;vertical-align:middle}.gt-grid-widget .dropdown-toggle .caret{margin:10px 4px 0 2px}.gt-grid-widget .dropdown-toggle:hover{background-color:#b4e0f4}.gt-grid-widget .input-append{margin-bottom:0}.gt-grid-widget .input-append input[type='text'],.gt-grid-widget .input-append .add-on{padding:3px 6px;height:21px}.gt-grid-widget .gt-filter-date-range-widget{width:475px}.gt-grid-widget .gt-grid-filter-dropdown-wrapper{padding:10px}.gt-grid-widget .gt-grid-filter-dropdown-wrapper .grid-filter-ct label{margin:0;font-size:.8em}.gt-grid-widget .gt-grid-filter-dropdown-wrapper input.search{margin-bottom:5px}.gt-grid-widget .gt-grid-filter-dropdown-wrapper ul{max-height:200px;overflow-y:auto;margin:0}.gt-grid-widget .gt-grid-filter-dropdown-wrapper ul li{color:#333;display:block;outline:0 none;text-decoration:none;padding:5px}.gt-grid-widget .gt-grid-filter-dropdown-wrapper ul li label{margin:0}.gt-grid-widget .gt-grid-filter-dropdown-wrapper ul li:hover{background-color:#39f;color:white}.alt-bg2{background-color:#f7f7f7}.dotted{border:1px dashed #ddd;border-radius:4px}.right-border{border-right:1px solid #e5e5e5}.small-info-box{text-align:center}.small-info-box .title{font-size:.9em;font-color:lighter(#333,15%)}.small-info-box .box{padding:15px;font-size:3em;font-weight:bold;border:1px dashed #eee;border-radius:10px;background-color:#eee}.leave-balance{width:150px;margin:0 auto;margin-bottom:10px}.resignEmp{color:#ce2121}.emp-segment{margin:5px 10px 0 20px}.emp-segment .current-segment{padding:3px;border:1px solid #cecece;background-color:#dffcd1;display:inline-block;border-radius:4px;margin-right:10px;color:#333}.emp-segment .current-segment.ng-enter,.emp-segment .current-segment.ng-leave{-webkit-transition:all ease .4s;-moz-transition:all ease .4s;-o-transition:all ease .4s;transition:all ease .4s;position:relative}.emp-segment .current-segment.ng-enter{opacity:.5;left:1000px}.emp-segment .current-segment.ng-enter.ng-enter-active{opacity:1;left:0}.emp-segment .current-segment.ng-leave{opacity:1;left:0}.emp-segment .current-segment.ng-leave.ng-leave-active{opacity:0;left:-500px}.emp-segment .current-segment i{color:#999}.emp-segment .current-segment i:hover{color:#333}.hide-sidebar.right{text-align:right}.clear-demo{position:absolute;display:inline-block;width:150px;padding:0 5px;top:0;left:50%;margin-left:-75px;background-color:#e79968;color:#dfdfdf;border:2px solid #FFF;border-top:0;border-radius:0 0 5px 5px;text-align:center;font-weight:bold;font-size:.8em}.clear-demo:hover{background-color:#e07b3c;color:#fff}.key-message{position:absolute;width:450px;padding:0 5px;top:30px;left:50%;margin-left:-225px;background-color:#297dd1;color:#FFF;border-radius:15px;text-align:center;font-size:.9em}.key-message:hover{background-color:#e07b3c;color:#fff}.key-message.ok{background-color:#177c37}.key-message.warn{background-color:#bc9f3e}.key-message.urgent{background-color:#bf2f1c}.wf-button{margin-right:10px}.wf-summary .accordion-heading{background-color:#dbf0f9}.wf-summary .accordion-group{border:1px solid #DDD;border-radius:0;margin-bottom:5px}.wf-summary .accordion-inner{border-top:1px solid #dbdbdb;padding:9px 20px}.wf-summary .accordion-body{background-color:#fff}.wf-detail .header{background-color:#dbf0f9}.empName h4{margin:0}.input-button{margin-bottom:10px}.input-text{display:inline-block;vertical-align:middle;height:10px;line-height:0}.cke_contents img,.ck-content-preview img{border:0}.cke_contents h1,.ck-content-preview h1,.cke_contents h2,.ck-content-preview h2{font-weight:bold}.cke_contents h1,.ck-content-preview h1,.cke_contents h2,.ck-content-preview h2,.cke_contents h3,.ck-content-preview h3,.cke_contents h4,.ck-content-preview h4,.cke_contents h5,.ck-content-preview h5{margin:6px 0 12px 0;color:#333;line-height:20px}.cke_contents h1,.ck-content-preview h1{font-size:25px}.cke_contents h2,.ck-content-preview h2{font-size:20px}.cke_contents h3,.ck-content-preview h3{font-size:18px}.cke_contents h4,.ck-content-preview h4{font-size:16px}.cke_contents h5,.ck-content-preview h5{font-size:14px}.ui-datepicker{z-index:1051!important}body.print{background:0}body.print .no-print{display:none}body.print .only-print{display:block}body.print .print-header{margin:0 auto;position:relative;width:100%}body.print .print-header.left .logo,body.print .print-header.right .logo{position:absolute}body.print .print-header.left .logo{left:0}body.print .print-header.right .logo{right:0}body.print .print-header .company{text-align:center}body.print .inner-content{right:auto}body.print .inner-content .app-content{float:none;left:auto;width:100%}body.print .main-content{min-height:200px}body.print #app-container .page-header .page-title{text-align:center;border:0}#home-page .tab-container{background:url(images/bgfit.png) no-repeat center center fixed;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover}#home-page ul.nav-tabs{margin-bottom:10px}.gt-home .navbar-static{margin-bottom:0}.gt-home .content{margin-top:0}.payroll-checklist li{padding:5px 10px;margin-bottom:15px}.payroll-checklist li.ng-enter,.payroll-checklist li.ng-leave{-webkit-transition:all linear .3s;-moz-transition:all linear .3s;-o-transition:all linear .3s;transition:all linear .3s;position:relative}.payroll-checklist li.ng-enter{opacity:.5;left:-50px}.payroll-checklist li.ng-enter.ng-enter-active{opacity:1;left:0}.payroll-checklist li.ng-leave{opacity:1;left:0}.payroll-checklist li .actions{display:none;margin:0;padding:0;margin-left:30px}.payroll-checklist li button{margin-right:10px}.payroll-checklist li:hover{background-color:#efefef}.payroll-checklist li:hover .actions{display:inline-block}.payroll-checklist.done .title{text-decoration:line-through}.gts-calendar{width:100%}.gts-calendar .cal-top-bar{font-weight:bold;padding-bottom:5px;text-align:center}.gts-calendar .cal-top-bar .cal-title{padding-top:4px;font-size:1.2em}.gts-calendar .cal-top-bar .prev{float:left}.gts-calendar .cal-top-bar .next{float:right}.gts-calendar .cal-table{table-layout:fixed;width:100%}.gts-calendar .cal-table .tbl-title,.gts-calendar .cal-table .tbl-day{border:1px solid #CCC;text-align:center;width:14.27%}.gts-calendar .cal-table .tbl-title{font-weight:bold;padding:3px}.gts-calendar .cal-table .tbl-day{overflow:hidden;vertical-align:top;user-select:none;-moz-user-select:none;-khtml-user-select:none}.gts-calendar .cal-table .tbl-day-content{height:100%;overflow:hidden;position:relative}.gts-calendar .cal-table .tbl-day-content.default-view{display:table-cell;vertical-align:middle}.gts-calendar .cal-table .tbl-day-content.custom-view{text-align:left;position:relative}.gts-calendar .cal-table .tbl-day.prev,.gts-calendar .cal-table .tbl-day.next{opacity:.5}.gts-calendar .cal-table .tbl-day.active{border:1px solid blue}.gts-calendar .cal-table .brdr-b-hide{border-bottom:0}.gts-calendar .cal-table .brdr-r-hide{border-right:0}.my-account .plan-container{background-color:#707070;border-bottom:1px solid #000;width:100%;border-radius:8px;text-align:center;color:#fff;font-family:"Open Sans",Arial;margin-bottom:15px}.my-account .plan-container .title{padding:2px;line-height:25px;font-size:15px;font-weight:bold;text-shadow:0 1px 0 #000}.my-account .plan-container .title-triangle{border-top:8px solid #707070;border-left:8px solid transparent;border-right:8px solid transparent;width:0;height:0;margin:0 auto}.my-account .plan-container .content{background-color:#f2f2f2;color:#333;min-height:200px;height:auto}.my-account .plan-container .top-content{padding-top:5px}.my-account .plan-container .top-content .continued{font-style:italic;padding:10px 0;margin:0 20px;border-bottom:1px dotted #666}.my-account .plan-container .top-content ul{list-style-type:none;margin:0;margin-top:15px}.my-account .plan-container .top-content li{padding:5px 0;margin:0}.my-account .plan-container .footer-triangle{border-top:8px solid #f2f2f2;border-left:8px solid transparent;border-right:8px solid transparent;width:0;height:0;margin:0 auto}.my-account .plan-container .footer{background-color:#979797}.my-account .plan-container .footer2{height:21px}.my-account .plan-container .footer-content{padding:30px 0 6px 0}.my-account .plan-container .rupee{background:url(images/re.png) no-repeat top left}.my-account .plan-container .big{font-size:3em;font-weight:600;padding-left:20px;text-shadow:0 1px 0 #333}.my-account .plan-container .bundled{font-size:.85em}.my-account .cluetip{background:url("images/help.png") no-repeat scroll right center rgba(0,0,0,0);display:inline-block;padding:3px 0;width:32px;text-decoration:none}.my-account .plan-bantam{background-color:#707070}.my-account .plan-bantam .title-triangle{border-top-color:#707070}.my-account .plan-bantam .footer{background-color:#979797}.my-account .plan-welter{background-color:#2f9d89}.my-account .plan-welter .title-triangle{border-top-color:#2f9d89}.my-account .plan-welter .footer{background-color:#3db49e}.my-account .plan-super{background-color:#0091bb}.my-account .plan-super .title-triangle{border-top-color:#0091bb}.my-account .plan-super .footer{background-color:#48aecb}.my-account .plan-cruiser{background-color:#e2536b}.my-account .plan-cruiser .title-triangle{border-top-color:#e2536b}.my-account .plan-cruiser .footer{background-color:#e78293}.my-account .btn-selectPlan{background-color:#84ac3d;background-image:linear-gradient(to bottom,#629c44,#84ac3d);background-repeat:repeat-x;border-color:#4c7a34;color:#fff;text-shadow:0 -1px 0 rgba(0,0,0,0.25)}.my-account .btn-selectPlan:hover,.my-account .btn-selectPlan:active,.my-account .btn-selectPlan.active,.my-account .btn-selectPlan.disabled,.my-account .btn-selectPlan[disabled],.my-account .form-submit:hover,.my-account .form-submit.active,.my-account .form-submit[disabled],.my-account .btn-selectPlan:focus{background-color:#84ac3d;border-color:#84ac3d;color:#fff}.my-account .pad-bottom15{margin-bottom:15px}.my-account .pad-bottom10{margin-bottom:10px}.my-account .pad-bottom5{margin-bottom:5px}.my-account .popover-title{color:#000;text-align:left}.my-account .popover-content{padding:9px 14px;text-align:left;color:#737373}.my-account .plan-details-contents{width:95%;padding:30px;margin:0 auto;border-radius:25px}.my-account .plan-heading{font-size:30px;font-weight:300;color:#fff;padding:8px;margin:0}.my-account .plan-details-triangle{border-left:15px solid transparent;border-right:15px solid transparent;height:0;width:0;position:relative;margin:-20px auto 7px}.my-account .bantam-plan-bg{background:-moz-linear-gradient(bottom,#b3b5b4,#ebebeb 4%);background:-webkit-linear-gradient(bottom,#b3b5b4,#ebebeb 4%)}.my-account .bantam-plan-head-bg{background:-moz-linear-gradient(left,#717171,#ebebeb);background:-webkit-linear-gradient(left,#717171,#ebebeb)}.my-account .bantam-plan-traingle-color{border-top:14px solid #b3b5b4}.my-account .bantam-plan-icon{color:#717171}.my-account .welter-plan-bg{background:-moz-linear-gradient(bottom,#a1d4cb,#eff8f7 4%);background:-webkit-linear-gradient(bottom,#a1d4cb,#eff8f7 4%)}.my-account .welter-plan-head-bg{background:-moz-linear-gradient(left,#3db49e,#eff8f7);background:-webkit-linear-gradient(left,#3db49e,#eff8f7)}.my-account .welter-plan-traingle-color{border-top:14px solid #a1d4cb}.my-account .welter-plan-icon{color:#3db49e}.my-account .super-plan-bg{background:-moz-linear-gradient(bottom,#8acce2,#e9f7fa 4%);background:-webkit-linear-gradient(bottom,#8acce2,#e9f7fa 4%)}.my-account .super-plan-head-bg{background:-moz-linear-gradient(left,#0292b7,#e9f7fa);background:-webkit-linear-gradient(left,#0292b7,#e9f7fa)}.my-account .super-plan-traingle-color{border-top:14px solid #8acce2}.my-account .super-plan-icon{color:#0292b7}.my-account .cruiser-plan-bg{background:-moz-linear-gradient(bottom,#ecabb3,#fbf2f3 4%);background:-webkit-linear-gradient(bottom,#ecabb3,#fbf2f3 4%)}.my-account .cruiser-plan-head-bg{background:-moz-linear-gradient(left,#dd536c,#fbf2f3);background:-webkit-linear-gradient(left,#dd536c,#fbf2f3)}.my-account .cruiser-plan-traingle-color{border-top:14px solid #ecabb3}.my-account .cruiser-plan-icon{color:#dd536c}.my-account .current-plan-shadow{margin-top:-27px;box-shadow:1px 10px 20px #585858}.my-account .plan-container .current-plan-content{min-height:250px}.my-account .plan-default-bg{background-color:#cbcbcb}.my-account .plan-container .triangle-default-bg{border-top:8px solid #cbcbcb}.my-account .content-default-bg{background-color:#f8f8f8}.my-account .plan-container .footer-default-bg{background-color:#cbcbcb}.my-account .features-default-text{color:#9d9d9d}.my-account .text-default-color{color:#ededed}.my-account .upDownGrade-text{font-size:19px;font-family:'Trebuchet MS';color:#555c67}.my-account .plans-features{width:auto;margin:15px;padding:15px;border:1px solid #aaa;border-radius:5px}.my-account .feature-caption{margin-top:0}.my-account .currentplan-font{font-weight:normal}.my-account .plan-pad-bottom10{margin-bottom:10px}.error-color{color:#9d261d}.ok-color{color:#46a546}.form16-ov-panel{border:1px solid #d6d6d6}.form16-ov-panel .dashlet-header{background-color:#d6d6d6;border:2px solid #fff;padding:9px 15px}.form16-ov-panel .dashlet-body{overflow-y:auto;padding:15px;position:relative;height:110px;background-color:#fff}.form16-ov-panel .dashlet-footer{border-top:1px solid #ddd;margin-bottom:0;padding:14px 15px 45px;text-align:right;clear:both;content:"";line-height:0;background-color:#fff}.form16-ov-panel .dashboard-help{color:#fff;cursor:pointer}.form16-ov-panel .dashboard-btnwidth{width:115px}.form16-dashboard-container{border:1px solid #d3e5f1;background-color:#eff5f7;color:#000;box-shadow:none}.form-horizontal .control-group .controls .gt-controls-text{padding-top:5px}.gt-accordion accordion h3{margin:0;line-height:20px}.gt-accordion .row-even{background-color:#f3f3f3}.gt-accordion .row-odd{background-color:#fdfdfd}.gt-accordion .accordion-heading .accordion-toggle{padding-top:0;padding-bottom:0}.gt-accordion .column-no-border{padding-bottom:8px;padding-top:8px}.gt-accordion .column{border-right:1px solid #d6d6d6;padding-bottom:8px;padding-top:8px}.asset-info-blockquote .img-div{height:100%;min-height:100%;display:table-cell;float:none;vertical-align:middle}.asset-info-blockquote .row-fluid{display:table}.asset-info-blockquote .data-div{display:table-cell;float:none}.mt10{margin-top:10px}.text-black{color:black}.text-orange{color:orange}.directoryConfig .rightpanel{background-color:#c7e4d3;margin-left:140px!important;border-radius:12px;margin-bottom:20px;min-height:500px}.directoryConfig .padding-top{padding-top:5%}.directoryConfig .stl{float:right;color:#5f5f5f;width:50%;text-align:right}.directoryConfig .tdright{width:50%;text-align:left;padding-left:2px}.directoryConfig .inner-col{margin:0}.directoryConfig .destd{color:#5f5f5f}.directoryConfig .img-circle{width:100px;height:100px;border-radius:100px;border:2px solid #8ab872}.directoryConfig .h1,.directoryConfig h2,.directoryConfig h3,.directoryConfig h4,.directoryConfig h5,.directoryConfig h6{margin:0}.directoryConfig .table{margin-bottom:-20px}.directoryConfig .tr{width:100%;margin:5px}.directoryConfig .mouseover:hover{background-color:#fff0c6;border:1px dashed #a88b35;cursor:move;height:18px;overflow:hidden;padding:3px}.directoryConfig .gt-field-list li{list-style-type:none;padding-top:10px}.directoryConfig .header{border-bottom:1px solid #88b779;color:#6aa150;font-size:1em;text-align:center;text-transform:uppercase}.directoryConfig .node-button{border-radius:10px;height:11px;width:11px}.directoryConfig .node-button.expander{border:1px solid black}.directoryConfig .node-button.collapser{border:1px solid black}.directoryConfig .sample{margin-left:265px;margin-top:9px;color:#6aa150}.directoryConfig .footer{background:#fff;color:#6aa150;text-align:center;position:relative;margin-top:200px}.blockui{background-color:grey;bottom:0;height:100%;left:0;opacity:.5;position:fixed;right:0;top:0;width:100%;z-index:10000}.blockMsg{background-color:#ffe9cc;border:#ffbc66 2px solid;color:#3a87ad;bottom:40%;font-size:1.0em;height:100px;left:35%;padding-top:20px;position:absolute;right:40%;top:40%;vertical-align:top;width:30%;border:2px solid;border-radius:10px;-moz-border-radius:10px;z-index:10025}
.highlight{
    color:#ff0000;
    display: inline-block;
}

ul
{
        list-style: none;
}
li
{
    line-height:25px;
}
.inp
{
display: block;
    width: 100%;
   
    padding: 4px 12px;
    font-size: 14px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #ccc;
   
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>
    <script src="js/jquery-1.4.4.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $('.inp').keyup(function () {
                var val = this.value;
                if (val != "") {
                    $('ul li').each(function () {
                        var litext = $(this).text().toLowerCase();
                        if (val == litext) {
                            $(this).show();
                            $(this).css("background-color", "#DAF7A6");
                        }
                        else {

                        }
                    });
                }
                else {
                    location.reload();
                    this.value = "";
                }
            })
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="content">
           
        <div class="box box-info">
         <div class="box-header with-border">
                <h3 class="box-title">
                    <i style="padding-right: 5px;" class="glyphicon glyphicon-briefcase"></i>Reports Gallery
                </h3>
            </div>
            <div class="box-body">
            <div style="text-align:center;">
          
                           <table align="center">
                                        <tr>
                                          <td>
             <input type="text" id="txtsearch" class="inp" class="form-control" placeholder="Search form name"/>
              </td>
                                    <td>
              <span class="input-group-btn">
                                            <button type="button" class="btn btn-info btn-flat" style="height: 30px;">
                                                <i class="fa fa-search" aria-hidden="true"></i>
                                            </button>
                                        </span>

                                            </td>
                                            </tr>
                                            </table>
                            <br />
                            </div>

               <div id="all_text" class="main-content" style="padding-top:15px;">
                 <div id="main" ng-show="tab == 'main'" class="tab-pane">
                <!-- ui-view-anchor -->
                <div ui-view="main" class="">
                    <!-- ui-view-anchor -->
                    <div id="app-container" ui-view="" class="app-container ng-scope">
                        <!-- ui-view-anchor -->
                        <div ui-view="" class="ng-scope">
                            <!-- ngIf: repeatGroup.length > 0 -->
                            <div class="row-fluid ng-scope" ng-if="repeatGroup.length > 0">
                            
                            <div class="topnav" style="background-color: white;">


                            <div class="box box-success">
                              <div class="box-header with-border" style="background-color: #16a085;color: white;font-weight: 700;font-size: 16px;">
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-bars"></i>Orders
                            </h3>
                           </div>
                              <div class="box-body">  
                            <table class="table table-responsive">
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                            <ul>
                           <li id="liorder"><a href="Order_Report.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Orders</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
                            <li id="litotalindent"><a href="IndentReport.aspx"><i class="fa fa-share"></i>&nbsp Total Indent</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
                           <li id="li36"><a href="indentCrates.aspx"><i class="fa fa-share"></i>&nbsp Indent Crates</a></li>
                           </ul>
                            </td>
                            <td>
                              <ul>
                           <li id="li19"><a href="RouteInfo.aspx"><i class="fa fa-share"></i>&nbsp Route Info</a></li>
                           </ul>
                           </td>
                            <td>
                             <ul>
                           <li id="liroutesheet"><a href="RouteSheet.aspx"><i class="fa fa-share"></i>&nbsp RouteSheet</a></li>
                           </ul>
                            </td>
                            </tr>
                            </table>
                            </tr>
                           </table>
                              </div>
                            </div>

                            <div class="box box-info">
                            <div class="box-header with-border" style="background-color: #00c0ef;color: white;font-weight: 700;font-size: 16px;">
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-line-chart"></i>Sales
                            </h3>
                           </div>
                            <div class="box-body">  
                            <table>
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                              <ul>
                          <li id="lidelivery"><a href="Delivery_report.aspx"><i class="fa fa-share"></i>&nbsp Deliveries</a></li>
                          </ul>
                            </td>
                            <td>
                            <ul>
                          <li id="lidelivery_sheet"><a href="Derivery_sheet.aspx"><i class="fa fa-share"></i>&nbsp Delivery History</a></li>
                          </ul>
                            </td>
                            <td>
                             <ul>
                           <li id="lirouteWdelivery"><a href="RouteWiseDelivery.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Delivery</a></li>
                           </ul>
                            </td>
                          
                            <td>
                            <ul>
                            <li id="li63"><a href="AgentAvgSale.aspx"><i class="fa fa-share"></i>&nbsp Agent Avg Sale</a></li>
                            </ul>
                            </td>
                           
                            </tr>
                            <tr>
                             <td>
                            <ul>
                        <li id="liroutewisedeliverymontly"><a href="monthlyroutewisedelivery.aspx"><i class="fa fa-share"></i>&nbsp Monthly Route
                                                    Wise Delivery</a></li>
                            </ul>
                            </td>

                            <td>
                            <ul>
                            <li id="licollection"><a href="Delivery_Collection_Report.aspx"><i class="fa fa-share"></i>&nbsp Net Sales Report</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                          <li id="li23"><a href="ClosingStock.aspx"><i class="fa fa-share"></i>&nbsp Closing Stock</a></li>
                            </ul>
                            </td>
                             <td>
                            <ul>
                          <li id="lioffereport"><a href="OfferIndent.aspx"><i class="fa fa-share"></i>&nbsp Offer Indent Delivery</a></li>
                            </ul>
                            </td>
                            
                            
                            </tr>
                            <tr>
                             <td>
                            <ul>
                  <li id="lisalesofficecollection"><a href="SalesOfficeCollection.aspx"><i class="fa fa-share"></i>&nbsp SalesOffice Collections</a></li>
                            </ul>
                            </td>
                             <td>
                            <ul>
                     <li id="liroutewisecollections"><a href="RouteWiseCollections.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Collections</a></li>
                            </ul>
                            </td>


                            <td>
                            <ul>
                         <li id="liAgentTransaction"><a href="AgentTransaction.aspx"><i class="fa fa-share"></i>&nbsp Agent Statement</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                              <li id="li47"><a href="TotalReport.aspx"><i class="fa fa-share"></i>&nbsp Sangam Report</a></li>
                            </ul>
                            </td>
                           
                            
                            </tr>
                            <tr>
                            <td>
                            <ul>
                              <li id="liSalesOfficewiseActivity"><a href="SalesOfficeWiseActivity.aspx"><i class="fa fa-share"></i>&nbsp SalesOffice
                            </ul>
                            </td>
                            <td>
                            <ul>
                           <li id="linewagentreport"><a href="NewAgentReport.aspx"><i class="fa fa-share"></i>&nbsp New Agent Report</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                        <li id="li15"><a href="BranchWiseDispatch.aspx"><i class="fa fa-share"></i>&nbsp Branch Wise Despatch</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                           <li id="li14"><a href="NetSalesBranchWise.aspx"><i class="fa fa-share"></i>&nbsp Net Sales Branch Wise</a></li>
                            </ul>
                            </td>

                           
                            
                            </tr>
                            <tr>
                            <td>
                            <ul>
                         <li id="liAgentMonthlyProducts"><a href="AgentMonthlyProducts.aspx"><i class="fa fa-share"></i>&nbsp Agent Monthly Transaction</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                          <li id="liSalesOfficeStock"><a href="SalesOfficeStock.aspx"><i class="fa fa-share"></i>&nbsp Sales Office Stock</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                         <li id="HelperCharges"><a href="HelperCharges.aspx"><i class="fa fa-share"></i>&nbsp Helper Charges</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                       <li id="liduereport"><a href="AgentDueReport.aspx"><i class="fa fa-share"></i>&nbsp Due Report</a></li>
                            </ul>
                            </td>
                           
                            
                           </tr>
                           <tr>
                           <td>
                            <ul>
                    <li id="liroutewisedue"><a href="RouteWiseDue.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Due</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                  <li id="liagentinvoice"><a href="AgentInvoice.aspx"><i class="fa fa-share"></i>&nbsp Agent Invoice</a></li>
                            </ul>
                            </td>
                            <td>
                            <%--<ul>
                             <li id="li95"><a href="AgentInvoiceReport.aspx"><i class="fa fa-share"></i>&nbsp New AgentInvoice</a></li>
                            </ul>
                            </td>

                            <td>
                            <ul>--%>
                             <li id="litimingreport"><a href="TimingReport.aspx"><i class="fa fa-share"></i>&nbsp Timing Report</a></li>
                            </ul>
                            </td>
                           
                            
                           </tr>
                           <tr>
                           <td>
                            <ul>
                       <li id="liagentdelivery"><a href="AgentDelivery.aspx"><i class="fa fa-share"></i>&nbsp Agent Delivery</a></li>
                       </ul>
                            </td>
                            <td>
                            <ul>
                    <li id="li66"><a href="RouteVerification.aspx"><i class="fa fa-share"></i>&nbsp Trip Sheet</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                  <li id="li59"><a href="Freezer_Details_Report.aspx"><i class="fa fa-share"></i>&nbsp Freezer Details Report</a></li>
                            </ul>
                            </td>
                          
                            <td>
                            <ul>
            <li id="li98"><a href="StoppedAgentReport.aspx"><i class="fa fa-share"></i>&nbsp Stopped Agent Report</a></li>
                            </ul>
                            </td>
                           
                           </tr>

                           <tr>
                           <td>
                           <ul>
                         <li id="li33"><a href="agentavgmilk_curdsale.aspx"><i class="fa fa-share"></i>&nbsp Agent milk & curd avg Sale</a></li>
                            </ul>
                            </td>

                             <td>
                            <ul>
                          <li id="li12"><a href="Routewisesaleqty.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Sale Qty</a></li>
                            </ul>
                            </td>

                             <td>
                            <ul>
                             <li id="liRouteWiseActivity"><a href="RouteWiseActivity.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Activity</a></li>
                            </ul>
                            </td>

                             <td>
                            <ul>
                          <li id="li38"><a href="DaywiseMilkSales.aspx"><i class="fa fa-share"></i>&nbsp Day Wise Milk And Curd Sales</a></li>
                            </ul>
                            </td>

                            
                           </tr>

                           <tr>
                            <td>
                            <ul>
         <li id="li78"><a href="SalesRepresentative.aspx"><i class="fa fa-share"></i>&nbsp SR Wise Report</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                       <li id="liagentwisedue"><a href="AgentwiseDueReport.aspx"><i class="fa fa-share"></i>&nbsp Agent Wise Due</a></li>
                       </ul>
                            </td>

                             <td>
                            <ul>
                             <li id="liTimeline"><a href="TimeLine.aspx"><i class="fa fa-share"></i>&nbsp Time Line</a></li>
                            </ul>
                            </td>
                           
                           </tr>



                           </table>
                           </tr>
                           </table>
                           </div>
                           </div>

                            <div class="box box-danger">
                           <div class="box-header with-border" style="background-color: #df764e;color: white;font-weight: 700;font-size: 16px;">
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-scissors"></i>Leakages
                            </h3>
                           </div>
                           <div class="box-body">
                            <table>
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                            <ul>
                           <li id="li84"><a href="Puff_Leakes.aspx"><i class="fa fa-share"></i>&nbsp Puff Leaks Report</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
                            <li id="lileaksandreturns"><a href="LeaksAndReturns.aspx"><i class="fa fa-share"></i>&nbsp Leaks and Returns Report</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
                   <li id="litotleaksanddispatch"><a href="TotalLeakReturnDispatch.aspx"><i class="fa fa-share"></i>&nbsp Total Leaks Returns
                                                And Dispatch</a></li>
                           </ul>
                            </td>
                           
                            </tr>
                            <tr>
                             <td>
                              <ul>
                   <li id="litotalleaks"><a href="TotalLeaks.aspx"><i class="fa fa-share"></i>&nbsp Total Leaks and Returns</a></li>
                           </ul>
                           </td>
                            <td>
                            <ul>
                <li id="liverifiedleaks"><a href="VarifyingLeaks.aspx"><i class="fa fa-share"></i>&nbsp Verified Leaks and Returns</a></li>
                            
                            </ul>
                            
                            </td>

                            <td>
                            <ul>
           <li id="limonthlyverifiedleaks"><a href="MonthlyVerifiedLeaks.aspx"><i class="fa fa-share"></i>&nbsp Monthly Verified
                                                Leaks </a></li>                  
                            
                            </ul>
                            </td>
                            <tr>
                            <td>
                            <ul>
                       <li id="li58"><a href="SalesMenActivity.aspx"><i class="fa fa-share"></i>&nbsp Sales Men Activity</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
                      <li id="liLeakageActivityReport"><a href="LeakageActivityReport.aspx"><i class="fa fa-share"></i>&nbsp Leakage Activity</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
                  <li id="liLeaksConsolidatedReport"><a href="LeaksConsolidatedReport.aspx"><i class="fa fa-share"></i>&nbsp Branch Wise
                                                Leaks Consolidated Report</a></li>
                           </ul>
                            </td>
                            </tr>
                            </tr>
                            </table>
                            </tr>
                           </table>
                           </div>
                           </div>

                            <div class="box box-warning">
                            <div class="box-header with-border" style="background-color: #e0b84e;color: white;font-weight: 700;font-size: 16px;" >
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-shield"></i>Inventory
                            </h3>
                           </div>
                           <div class="box-body">
                            <table>
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                            <ul>
                           <li id="liinventoryreport"><a href="InventoryReport.aspx"><i class="fa fa-share"></i>&nbsp Inventory Details</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
                            <li id="lidaywiseinventory"><a href="CratesReport.aspx"><i class="fa fa-share"></i>&nbsp Day Wise Inventory Transactions</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
                   <li id="limonthlyroutewisecratesreport"><a href="MonthlyRouteWiseCratesReport.aspx"><i class="fa fa-share"></i>&nbsp Monthly Route Wise Inventory Transactions</a></li>
                           </ul>
                            </td>
                            
                            </tr>
                            <tr>
                            <td>
                              <ul>
                   <li id="liroutewisetransaction"><a href="RouteWiseCratesReport.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Inventory
                                                Transactions</a></li>
                           </ul>
                           </td>
                            <td>
                            <ul>
                 <li id="lidispatchwiseinventory"><a href="PuffWiseInventory.aspx"><i class="fa fa-share"></i>&nbsp Dispatch Wise Inventory
                                                Transactions</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
                <li id="li13"><a href="DayWisePuffInventory.aspx"><i class="fa fa-share"></i>&nbsp Day Wise Puff Inventory</a></li>
                             </ul>
                            </td>
                            </tr>
                            </table>
                            </tr>
                           </table>
                           </div>
                           </div>

                            <div class="box box-default">
                            <div class="box-header with-border" style="background-color: #a8b3ca;color: white;font-weight: 700;font-size: 16px;" >
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-money"></i>Incentive
                            </h3>
                           </div>
                           <div class="box-body">
                            <table>
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                            <ul>
                 <li id="incentivereport"><a href="IncentiveReport.aspx"><i class="fa fa-share"></i>&nbsp Incentive Report</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
               <li id="agentincentivereport"><a href="AgentWiseTotalIncentive.aspx"><i class="fa fa-share"></i>&nbsp Agent Wise Incentive</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
               <li id="Li16"><a href="RouteWiseIncentive.aspx"><i class="fa fa-share"></i>&nbsp Route Wise Incentive</a></li>
                           </ul>
                            </td>
                            <td>
                              <ul>
                    <li id="Liincentivestatement"><a href="monthlyagentwiseincentive.aspx"><i class="fa fa-share"></i>&nbsp Incentive Statement</a></li>
                           </ul>
                           </td>
                            </tr>
                            </table>
                            </tr>
                           </table>
                           </div>
                           </div>

                            <div class="box box-success">
                            <div class="box-header with-border" style="background-color: #6ab78a;color: white;font-weight: 700;font-size: 16px;" >
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-truck"></i>Despatch
                            </h3>
                           </div>
                           <div class="box-body">
                            <table>
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                              <ul>
                       <li id="lidcreport"><a href="Dc_print.aspx"><i class="fa fa-share"></i>&nbsp DC Report</a></li>
                          </ul>
                            </td>
                            
                          

                            <td>
                            <ul>
                  <li id="litotaldc"><a href="TotalDCReport.aspx"><i class="fa fa-share"></i>&nbsp Total DC Report</a></li>
                            </ul>
                            </td>
                           <td>
                            <ul>
                        <li id="li1"><a href="DayWiseDispatch.aspx"><i class="fa fa-share"></i>&nbsp Day Wise DC Report</a></li>
                            </ul>
                            </td>
                            <td>
                            <ul>
                <li id="liproductwisedcreport"><a href="ProductWiseTotalDCReport.aspx"><i class="fa fa-share"></i>&nbsp Product Wise
                                                Total DC Report</a></li>
                            </ul>
                            </td>
                            </tr><tr>
                             <td>
                            <ul>
                 <li id="li2"><a href="DispatchWiseDcReport.aspx"><i class="fa fa-share"></i>&nbsp Despatch Wise DC Report</a></li>
                            </ul>
                            </td>
                             
                          
                           <td>
                            <ul>
        <li id="PlantSales"><a href="PlantSales.aspx"><i class="fa fa-share"></i>&nbsp Net Sale</a></li>
                            </ul>
                            </td>
                             <td>
                            <ul>
     <li id="lidaywisedc"><a href="MonthlyProductwiseTransaction.aspx"><i class="fa fa-share"></i>&nbsp Monthly Product Wise
                                                Transaction</a></li>
                            </ul>
                            </td>
                             <td>
                            <ul>
           <li id="liReturnDC"><a href="ReturnDC.aspx"><i class="fa fa-share"></i>&nbsp Return DC</a></li>
                            </ul>
                            </td>
                           </tr>
                           </table>
                           </tr>
                           </table>
                           </div>
                           </div>
                           
                            <div class="box box-danger">
                            <div class="box-header with-border" style="background-color: #df764e;color: white;font-weight: 700;font-size: 16px;" >
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-text-height"></i>Tally Reports
                            </h3>
                           </div>
                           <div class="box-body">
                            <table>
                            
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                            <ul>
              <li id="li96"><a href="Tally_BiproductsSales.aspx"><i class="fa fa-share"></i>&nbsp Tally Sales</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
                 <li id="li64"><a href="TallyOthersSale.aspx"><i class="fa fa-share"></i>&nbsp Tally Other Sales</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
                <li id="li51"><a href="TallyCash_staffsales.aspx"><i class="fa fa-share"></i>&nbsp Tally Cash & Staff Sales</a></li>
                           </ul>
                            </td>
                            <td>
                              <ul>
                <li id="li52"><a href="TallyReceipts.aspx"><i class="fa fa-share"></i>&nbsp Tally Receipts</a></li>
                           </ul>
                           </td>
                            <td>
                             <ul>
              <li id="li54"><a href="TallyPayments.aspx"><i class="fa fa-share"></i>&nbsp Tally Payments</a></li>
                           </ul>
                            </td>
                            </tr>

                            <tr>
                            <td>
                            <ul>
              <li id="li69"><a href="TallyInward.aspx"><i class="fa fa-share"></i>&nbsp Tally Inward</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
            <li id="li73"><a href="TallyLeaks.aspx"><i class="fa fa-share"></i>&nbsp Tally Leaks</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
           <li id="li103"><a href="TallyIncenticeJv.aspx"><i class="fa fa-share"></i>&nbsp Tally Incentives</a></li>
                           </ul>
                            </td>
                            <td>
                              <ul>
           <li id="li50"><a href="SapProduction.aspx"><i class="fa fa-share"></i>&nbsp SAP Production</a></li>
                           </ul>
                           </td>
                            </tr>

                            </table>
                            </tr>
                           </table>
                           </div>
                           </div>

                            <div class="box box-info">
                            <div class="box-header with-border" style="background-color: #00c0ef;color: white;font-weight: 700;font-size: 16px;" >
                             <h3 class="box-title">
                               <i style="padding-right: 5px;" class="fa fa-strikethrough"></i>Sap Reports
                            </h3>
                           </div>
                           <div class="box-body">
                            <table>
                            
                            <tr>
                            <table style="width:100%; font-size: 15px !important;">
                            <tr>
                            <td>
                            <ul>
               <li id="li87"><a href="SapSale.aspx"><i class="fa fa-share"></i>&nbsp SAP Sales</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
               <li id="li102"><a href="SAP_Cash_staffsales.aspx"><i class="fa fa-share"></i>&nbsp SAP Cash & Staff Sales</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
                 <li id="li65"><a href="SapOtherSale.aspx"><i class="fa fa-share"></i>&nbsp SAP Other Sales</a></li>
                           </ul>
                            </td>
                            <td>
                              <ul>
                <li id="li88"><a href="SAPReceipts.aspx"><i class="fa fa-share"></i>&nbsp SAP Receipts</a></li>
                           </ul>
                           </td>
                            <td>
                             <ul>
              <li id="li89"><a href="SAPPayments.aspx"><i class="fa fa-share"></i>&nbsp SAP Payments</a></li>
                           </ul>
                            </td>
                            <td>
                            <ul>
                            <li id="li90"><a href="SAPInward.aspx"><i class="fa fa-share"></i>&nbsp SAP Inward</a></li>
                            </ul>
                            
                            </td>
                            </tr>

                            <tr>
                            <td>
                            <ul>
           <li id="li101"><a href="SAPLeaks.aspx"><i class="fa fa-share"></i>&nbsp SAP Leaks</a></li>
                           </ul>
                            </td>
                             <td>
                              <ul>
           <li id="li91"><a href="SAPLeaks_JV.aspx"><i class="fa fa-share"></i>&nbsp SAP Leaks JV</a></li>
                             </ul>
                            </td>
                            <td>
                              <ul>
            <li id="li99"><a href="SAPIncentives.aspx"><i class="fa fa-share"></i>&nbsp SAP Incentives</a></li>
                           </ul>
                            </td>
                            <td>
                              <ul>
          <li id="li100"><a href="SAP_SalesOrder.aspx"><i class="fa fa-share"></i>&nbsp SAP Sales Order</a></li>
                           </ul>
                           </td>

                            <td>
                              <ul>
           <li id="li92"><a href="SapSaleQuantity.aspx"><i class="fa fa-share"></i>&nbsp SAP Data Checking</a></li>
                           </ul>
                           </td>

                            </tr>

                            </table>
                            </tr>
                           </table>
                           </div>
                           </div>

                            </div>

                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
            </div>
        </div>
        
    </section>
</asp:Content>
