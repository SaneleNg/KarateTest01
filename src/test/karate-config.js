function () {
      var env = karate.env;

      if (!env) {
        env = 'DEV';
      }

       var config = {
          baseUrl : 'http://quotes.rest/qod/',
        };

      if (env == 'DEV') {
        config.baseUrl = 'http://quotes.rest/qod/';
      }
      else if(env == 'ETE'){
        config.baseUrl = 'https://nbpwappstkete01.nedete.net:2118/stokvel/v1';
      }
      else if(env == 'QA'){
          config.baseUrl = 'http://nppwappstkqa01.africa.nedcor.net:8085/';

    }
      karate.configure('connectTimeout', 30000);
      karate.configure('readTimeout', 60000);
      karate.log('karate.env system property is :', env);
      return config;
}