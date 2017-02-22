using System.Collections.Generic;
using System.Xml.Linq;

namespace ActivityMonitor
{
    public class Activity
    {
        public string User { get; set; }
        public string IP { get; set; }
        public string Browser { get; set; }
        public string Device { get; set; }
        public string TimeSpan { get; set; }
        public string Element { get; set; }
        public string Event { get; set; }
        public string Value { get; set; }

        public static XElement NewXElement(Activity a)
        {
            XElement element =
                    new XElement("Activity",
                      new XElement("User", a.User),
                      new XElement("IP", a.IP),
                      new XElement("Browser", a.Browser),
                      new XElement("Device", a.Device),
                      new XElement("TimeSpan", a.TimeSpan),
                      new XElement("Element", a.Element),
                      new XElement("Event", a.Event),
                      new XElement("Value", a.Value));
            return element;
        }
        //private string GetOS ()
        //{
        //    Dictionary<string, string> osList = new Dictionary<string, string>() { 
        //    {"Windows NT 6.3", "Windows 8.1"},
        //    {"Windows NT 6.2", "Windows 8"},
        //    {"Windows NT 6.1", "Windows 7"},
        //    {"Windows NT 6.0", "Windows Vista"},
        //    {"Windows NT 5.2", "Windows Server 2003"},
        //    {"Windows NT 5.1", "Windows XP"},
        //    {"Windows NT 5.0", "Windows 2000"}
        //};
    }
}
