Select Top 1000000 tsysAssetTypes.AssetTypeIcon16 As icon,
  tblAssets.AssetID,
  tblAssets.AssetName,
  tblAssets.Description,
  tblAssetCustom.Manufacturer,
  tblAssetCustom.Model,
  tblRegistry.Regkey,
  Case
    When tblRegistry.Value = 0 Then 'DISABLED'
    When tblRegistry.Value = 1 Then 'ENABLED'
    Else 'UNKNOWN'
  End As FirewallStatus,
  tblAssets.Lastseen
From tblAssets
  Inner Join tsysAssetTypes On tblAssets.Assettype = tsysAssetTypes.AssetType
  Inner Join tblAssetCustom On tblAssets.AssetID = tblAssetCustom.AssetID
  Inner Join tblRegistry On tblAssets.AssetID = tblRegistry.AssetID
Where
  tblRegistry.Regkey Like
  'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\%'
Order By tblAssets.AssetName
