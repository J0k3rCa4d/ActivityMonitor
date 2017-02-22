using System;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Xml.Linq;

namespace ActivityMonitor
{
    public class ActivityFile
    {
        internal enum Key {Path, Name, Size, Days };

        internal static string AppSettingsValue(Key key)
        {
            var skey = string.Empty;
            var dllpath = new Uri(Assembly.GetExecutingAssembly().GetName().CodeBase).LocalPath;
            var dllconfig = ConfigurationManager.OpenExeConfiguration(dllpath);
            var appSettings = (AppSettingsSection)dllconfig.GetSection("appSettings");

            switch (key)
            {
                case Key.Path: skey = "Path"; break;
                case Key.Name: skey = "Name"; break;
                case Key.Size: skey = "Size"; break;
                case Key.Days: skey = "Days"; break;
                default: skey = "Path"; break;
            }
            return appSettings.Settings[skey].Value;
        }

        public void SaveActivites(object activites)
        {
            try
            {
                var dir = AppSettingsValue(Key.Path);

                if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

                var about = Path.Combine(dir, "About.xml");
                var file = Path.Combine(dir, $"ActivityMonitor_{Guid.NewGuid().ToString()}.xml");

                Activity[] _activitesArray = activites as Activity[];

                var xmlFile = new XElement("Activities");
                for (int i = 0; i < _activitesArray.Count(); i++)
                    xmlFile.Add(Activity.NewXElement(_activitesArray[i]));

                xmlFile.Save(file);
            }
            finally
            {
                Debug.WriteLine("File could't be saved, err ocure in ActivityMonitor.dll, please contact with bmisiuta@gmail.com");
            }
        } 
    }
}
