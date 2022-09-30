param webAppName string = uniqueString(resourceGroup().id)
param website string
param sku string = 'S1'
param linuxFxVersion string 
param location string  
var appServicePlanName = toLower('AppServicePlan-${webAppName}')
var webSiteName = toLower('${website}-${webAppName}')
param  numberOfWorkers int = 1
param tier string = 'Basic'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
    
  }
  sku: {
    name: sku
    tier: tier
  }
  kind: 'linux'
}
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      numberOfWorkers:numberOfWorkers

    }
  }
}
