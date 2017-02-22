using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace testui.Sites
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var s = new StringBuilder();
            HttpBrowserCapabilities bc = Request.Browser;
            s.Append("Type = " + bc.Type + "<br>");
            s.Append("Name = " + bc.Browser + "<br>");
            s.Append("Platform = " + bc.Platform + "<br>");
            s.Append("Is Crawler = " + bc.Crawler + "<br>");
            s.Append("Agent = " + Request.UserAgent + "<br>");
            broserinfo.Text = s.ToString();
        }
    }
}