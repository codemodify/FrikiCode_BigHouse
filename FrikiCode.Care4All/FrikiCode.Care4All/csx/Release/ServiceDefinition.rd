<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="FrikiCode.Care4All" generation="1" functional="0" release="0" Id="54eb82dd-34a7-4a51-a539-85e58cab9187" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="FrikiCode.Care4AllGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="FrikiCode.Care4All.Api:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/LB:FrikiCode.Care4All.Api:Endpoint1" />
          </inToChannel>
        </inPort>
        <inPort name="FrikiCode.Care4All.WebUi:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/LB:FrikiCode.Care4All.WebUi:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="FrikiCode.Care4All.Api:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/MapFrikiCode.Care4All.Api:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="FrikiCode.Care4All.ApiInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/MapFrikiCode.Care4All.ApiInstances" />
          </maps>
        </aCS>
        <aCS name="FrikiCode.Care4All.WebUi:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/MapFrikiCode.Care4All.WebUi:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="FrikiCode.Care4All.WebUiInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/MapFrikiCode.Care4All.WebUiInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:FrikiCode.Care4All.Api:Endpoint1">
          <toPorts>
            <inPortMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.Api/Endpoint1" />
          </toPorts>
        </lBChannel>
        <lBChannel name="LB:FrikiCode.Care4All.WebUi:Endpoint1">
          <toPorts>
            <inPortMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUi/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapFrikiCode.Care4All.Api:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.Api/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapFrikiCode.Care4All.ApiInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.ApiInstances" />
          </setting>
        </map>
        <map name="MapFrikiCode.Care4All.WebUi:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUi/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapFrikiCode.Care4All.WebUiInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUiInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="FrikiCode.Care4All.Api" generation="1" functional="0" release="0" software="C:\FrikiCode\FrikiCode.Care4All\FrikiCode.Care4All\csx\Release\roles\FrikiCode.Care4All.Api" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="8080" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;FrikiCode.Care4All.Api&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;FrikiCode.Care4All.Api&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;FrikiCode.Care4All.WebUi&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="FrikiCode.Care4All.Api.svclog" defaultAmount="[1000,1000,1000]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.ApiInstances" />
            <sCSPolicyUpdateDomainMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.ApiUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.ApiFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
        <groupHascomponents>
          <role name="FrikiCode.Care4All.WebUi" generation="1" functional="0" release="0" software="C:\FrikiCode\FrikiCode.Care4All\FrikiCode.Care4All\csx\Release\roles\FrikiCode.Care4All.WebUi" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;FrikiCode.Care4All.WebUi&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;FrikiCode.Care4All.Api&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;r name=&quot;FrikiCode.Care4All.WebUi&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUiInstances" />
            <sCSPolicyUpdateDomainMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUiUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUiFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="FrikiCode.Care4All.ApiUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyUpdateDomain name="FrikiCode.Care4All.WebUiUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="FrikiCode.Care4All.ApiFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyFaultDomain name="FrikiCode.Care4All.WebUiFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="FrikiCode.Care4All.ApiInstances" defaultPolicy="[1,1,1]" />
        <sCSPolicyID name="FrikiCode.Care4All.WebUiInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="d8dc7aa5-7f63-488a-83f6-30889ef11a60" ref="Microsoft.RedDog.Contract\ServiceContract\FrikiCode.Care4AllContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="6c0e9030-7798-46d1-a1d0-5d602f13b214" ref="Microsoft.RedDog.Contract\Interface\FrikiCode.Care4All.Api:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.Api:Endpoint1" />
          </inPort>
        </interfaceReference>
        <interfaceReference Id="1cc4b233-265d-4a74-a1fe-062db6b44572" ref="Microsoft.RedDog.Contract\Interface\FrikiCode.Care4All.WebUi:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/FrikiCode.Care4All/FrikiCode.Care4AllGroup/FrikiCode.Care4All.WebUi:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>