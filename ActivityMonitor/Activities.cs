using System.Collections.Generic;
using System.Threading;

namespace ActivityMonitor
{
    public class Activities
    {
        public static int ListSize { get; set; } = 1000;

        static List<Activity> _activityList = new List<Activity>();
        static Activity[] _activityArray;
        static object _lock = new object();

        public static void AddActivity(Activity a)
        {
            lock (_lock)
            {
                if (_activityList.Count == ListSize)
                {
                    _activityArray = new Activity[_activityList.Count];
                    _activityList.CopyTo(_activityArray);
                    _activityList.Clear();

                    ActivityFile file = new ActivityFile();
                    ThreadPool.QueueUserWorkItem(file.SaveActivites, _activityArray);
                    _activityArray = null;
                }
                _activityList.Add(a);
            }
        }
    }
}
