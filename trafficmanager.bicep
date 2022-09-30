@description('Relative DNS name for the traffic manager profile, resulting FQDN will be <uniqueDnsName>.trafficmanager.net, must be globally unique.')
param uniqueDnsName string

param web1 string
param web2 string

@description('Name of the trafficManager being created')
param trafficManagerName string

param host1id string = resourceId('Microsoft.Web/sites','${web1}')
param host2id string = resourceId('Microsoft.Web/sites','${web2}')

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: trafficManagerName
  location: 'global'
  properties: {
    profileStatus: 'Enabled'
    trafficRoutingMethod: 'Performance'
    dnsConfig: {
      relativeName: uniqueDnsName
      ttl: 30
    }
    monitorConfig: {
      protocol: 'HTTPS'
      port: 443
      path: '/'
    }
    endpoints: [
      {
        name: 'adkwolekdns1'
        type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
        properties: {
          targetResourceId: host1id
          endpointStatus: 'Enabled'
        }
      }
      {
        name: 'adkwolekdns2'
        type: 'Microsoft.Network/trafficManagerProfiles/azureEndpoints'
        properties: {
          targetResourceId: host2id
          endpointStatus: 'Enabled'
        }
      }
    ]
  }
}
