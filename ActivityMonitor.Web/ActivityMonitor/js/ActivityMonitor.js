$(document).ready(function () {
    show();
})

function Activity(name, element, event, value) {
    this.Name = name;
    this.Element = element;
    this.Event = event;
    this.Value = value
}

function AjaxCaller(element, event, value) {
    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/ActivitMonitorHandler.ashx');
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.onload = function () {
        if (xhr.status === 200) {
            console.log("200 : " + xhr.responseText);
        }
        else
            console.log("Err : " + xhr.responseText);
    }
    xhr.send(JSON.stringify(new Activity("Misiut", element, event, value)));
}

function show() {
    var mainEle = document.getElementById("ProjectInfoTab")
    var all = mainEle.querySelectorAll("div > input:not([type=hidden]), div > textarea, div > select, div.date span.input-group-addon");

    for (var i = 0; i < all.length; i++) {
        $(all[i]).on("click focus change", function (e) {
            var value = null;
            if (e.type == "change") {
                value = String($(this).val());
            }
            AjaxCaller(this.id, e.type, value);
        });
    }
}