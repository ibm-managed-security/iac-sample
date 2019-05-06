local config = import 'config.jsonnet';

{
  provider: {
    ibm: {
      bluemix_api_key: config['bluemix_api_key']
    }
  },

  data: {
    ibm_app_domain_shared: {
      domain: {
        name: "mybluemix.net"
      }
    }
  },

  resource: {
    ibm_org: {
      org: {
        name: config['org']
      }
    },
    ibm_space: {
      space: {
        name: config['space'],
        org: "${ibm_org.org.name}",
        managers: [config['manager']],
        developers: [config['developer']]
      }
    },
    null_resource: {
      prepare_app_zip: {
        triggers: {
          app_version: config['app_version'],
          app_repo: config['app_repo']
        },
        provisioner: [{
          "local-exec": {
            command: |||
                mkdir -p /tmp/cfapp
                cd /tmp/cfapp
                git init
                git remote add origin %s
                git fetch
                git checkout -t origin/master
                zip -r /tmp/cfapp.zip *
            ||| % config.app_repo
          }
        }]
      }
    },
    ibm_app_route: {
      route: {
        depends_on: ["ibm_space.space"],
        domain_guid: "${data.ibm_app_domain_shared.domain.id}",
        space_guid: "${ibm_space.space.id}",
        host: config['route']
      }
    },
    ibm_app: {
      testapp: {
        depends_on: ["null_resource.prepare_app_zip"],
        name: "testapp",
        space_guid: "${ibm_space.space.id}",
        app_path: "/tmp/cfapp.zip",
        wait_time_minutes: 10,
        buildpack: "sdk-for-nodejs",
        disk_quota: 512,
        memory: 256,
        instances: 2,
        route_guid: ["${ibm_app_route.route.id}"],
        environment_json: {
          "somejson": "somevalue"
        },
        app_version: config['app_version']
      }
    }
  }
}
