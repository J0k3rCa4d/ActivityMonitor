using System;
using System.Web.UI;

namespace FMCSS
{
    public partial class FileData : Page
    {
      
            //           API               //
            // GetUploaded(project)   Cloud.Instance.GetUploadedFiles(project)
            // GetConverted(project) Cloud.Instance.GetConvertedFiles(project, "clientOnly");
            // GetZip(project)
            // GetZip(project, list)   Zip.Instance.CreateArchive(project, list);
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write($"{Request.UserAgent}, {Request.UserHostAddress}");
            Response.Write($"{Request.ServerVariables["HTTP_X_FORWARDED_FOR"]}, {Request.ServerVariables["REMOTE_ADDR"]}");
      
        }
    }
}