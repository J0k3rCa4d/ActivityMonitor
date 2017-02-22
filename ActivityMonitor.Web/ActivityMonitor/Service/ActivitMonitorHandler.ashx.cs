using ActivityMonitor;
using Newtonsoft.Json;
using System;
using System.Globalization;
using System.IO;
using System.Web;

namespace testui
{
    public class ActivitMonitorHandler : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            var root = context.Request.PhysicalApplicationPath;
            var jsonData = new StreamReader(context.Request.InputStream).ReadToEnd();
           
            try
            {
                if (jsonData != null)
                {
                    var activity = JsonConvert.DeserializeObject<Activity>(jsonData);
                    activity.IP = HttpUtility.HtmlEncode(context.Request.UserHostAddress);
                    activity.Browser = HttpUtility.HtmlEncode(context.Request.UserAgent);
                    activity.Device = HttpUtility.HtmlEncode(context.Request.Browser.IsMobileDevice);
                    activity.TimeSpan = DateTime.UtcNow.ToString("yyyy-MM-dd HH:mm:ss.fff", CultureInfo.InvariantCulture);
                    Activities.AddActivity(activity);
                }
                context.Response.Write("Done");
            }
            catch (Exception)
            {
                context.Response.Write("Something Went Wrong");
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}