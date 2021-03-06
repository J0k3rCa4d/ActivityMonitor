﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace testui.ActivityMonitor.Service
{
    [RoutePrefix("ActivityApi")]
    public class ActivityController : ApiController
    {
        [Route("")]
        [HttpGet]
        public string GetTime()
        {
            return $"Time from Api {DateTime.Now.ToString("HH:mm:ss:fff")}";
        }
    }
}
