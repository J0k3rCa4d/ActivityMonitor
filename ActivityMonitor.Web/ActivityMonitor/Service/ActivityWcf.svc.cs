using System;
using System.ServiceModel;
using System.ServiceModel.Activation;

namespace testui.ActivityMonitor.Service
{
    [ServiceContract(Namespace = "WcfService")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class ActivityWcf
    {  
    [OperationContract]
        public string GetTime()
        {
            return $"Hello from WCF {DateTime.Now.ToString("HH:mm:ss:fff")}";
        }
    }
}
