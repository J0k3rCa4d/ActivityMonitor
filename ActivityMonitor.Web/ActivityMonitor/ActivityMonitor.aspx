<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="ActivityMonitor.aspx.cs" Inherits="testui.Sites.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server" >
    <title>IndexPage</title>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    <div class="row">
        <div class="col-lg-3 col-md-3">
            <asp:Label ID="broserinfo" runat="server"></asp:Label>
        </div>
        <div class="col-lg-3 col-md-3">

            <h3>WCF Service </h3>
            <div id="WcfService">
                <div class="textbox"></div>
                <input type="button" class="btn btn-info" value="Call wcf service" onclick="return wcf_onclick()" />
            </div>
        </div>
        <div class="col-lg-3 col-md-3">
            <h3>Ws Service </h3>
            <div id="WsService">
                <div class="textbox"></div>
                <input type="button" class="btn btn-info" value="Call wcf service" onclick="return ws_onclick()" />
            </div>
        </div>
         <div class="col-lg-3 col-md-3">
            <h3>WebApi Service </h3>
            <div id="WebApiService">
                <div class="textbox"></div>
                <input type="button" class="btn btn-info" value="Call webapi service" onclick="return webapi_onclick()" />
            </div>
        </div>

    </div>
    <div class="row">
        <div class="col-lg-6 col-md-6">
            <div id="monitorarea" class="col-lg-3" style="height: 100px; border: 1px solid green; padding: 10px; overflow-y: scroll"></div>
            <div id="counterarea" class="col-lg-3" style="height: 100px; border: 1px solid red; padding: 10px; overflow-y: scroll"></div>
            <div class="form-group">
                <input id="callhandler" type="button" class="btn btn-lg btn-danger col-lg-2" value="Call Handler" />
                <input id="callOne" type="button" class="btn btn-lg btn-danger col-lg-2" value="Call one" />
                <input id="counter" type="button" class="btn btn-lg btn-danger col-lg-2" value="Counter" />
            </div>
        </div>
    </div>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScrMgr">
            <Services>
                <asp:ServiceReference Path="Service/ActivityWcf.svc" />
            </Services>
        </asp:ScriptManager>
    </form>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="Scripts" runat="server" >
    <script>
            var t0 = performance.now();
            var t1;
            var api = $("#WebApiService .textbox");

            function webapi_onclick() {
                api.html("");
                var current = new Date();
                api.append("<p>Calling Hello Api  " + current.getHours() + ":" + current.getMinutes() + ":" + current.getSeconds() + ":" + current.getUTCMilliseconds() + "</p>");

                var jqxhr = $.getJSON(location.origin + "/ActivityApi/", function () {
                    console.log("success");
                }).done(function (data) {
                    api.append(data);
                    t1 = performance.now();
                    api.append("<p> send in : " + Number(t1 - t0).toFixed(2) + "</p>");
                    console.log("second success");
                }).fail(function () {
                    console.log("error");
                });
            }
    </script>
    <script>
        var wstb = $("#WsService .textbox");

        function ws_onclick() {
            wstb.html("");
            var current = new Date();
            wstb.append("<p>Callin Hello WCF  " + current.getHours() + ":" + current.getMinutes() + ":" + current.getSeconds() + ":" + current.getUTCMilliseconds() + "</p>");
            ActivityMonitor.ActivityMonitor1.Hello(onSuccess);
        }
        function onSuccess() {
            wstb.append("<p>" + result + "</p>");
        }
    </script>
    <script>
            var t2 = performance.now();
            var t3;
            var wcftb = $("#WcfService .textbox");
            function wcf_onclick() {
                wcftb.html("");
                var current = new Date();
                wcftb.append("<p>Callin Hello WCF  " + current.getHours() + ":" + current.getMinutes() + ":" + current.getSeconds() + ":" + current.getUTCMilliseconds() + "</p>");
                var service = new WcfService.ActivityWcf();
                service.GetTime(onSuccess, null, null);
            }

            function onSuccess(result) {
                t3 = performance.now();
                wcftb.append("<p>" + result + "</p>");
                wcftb.append("<p> send in : " + Number(t3 - t2).toFixed(2) + "</p>");
            }

           
    </script>
    <script>
        var sendcounter = 0;
        var callone = $("#callOne");
        var monitorarea = $("#monitorarea");
        var handlercaller = $("#callhandler");


        function Activity(name, element, event, value) {
            this.Name = name;
            this.Element = element;
            this.Event = event;
            this.Value = value
        }

        function AjaxCaller(element, event, value) {
            sendcounter++;
            var xhr = new XMLHttpRequest();
            xhr.open('POST', '/ActivitMonitorHandler.ashx');
            xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
            xhr.onload = function () {
                if (xhr.status === 200)
                   console.log("200 : " + xhr.responseText);
                else 
                   console.log("Err : " + xhr.responseText);
            }
            xhr.send(JSON.stringify(new Activity("Misiut", element, event, value)));
           
        }

        function msg(id, type, value) {
            monitorarea.html("");
            var t0 = performance.now();
            AjaxCaller(id, type, value);
            var t1 = performance.now();
            monitorarea.prepend("<p>" + id + " send in : " + Number(t1 - t0).toFixed(2) + "</p>");
        }
        callone.click(function (event) {
            var value = String($(this).val())
                msg(this.id, event.type, value);
        });

        handlercaller.click(function (event) {
            var value = String($(this).val())
            for (var i = 0; i < 100; i++) {
                msg(this.id, event.type, value);
            }
        });
      
    </script>
</asp:Content>
