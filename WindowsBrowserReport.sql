Select Distinct Top (1000000) tblAssets.AssetID,
  tblAssets.AssetName,
  Coalesce(tsysOS.Image, tsysAssetTypes.AssetTypeIcon10) As icon,
  tblAssets.Lastseen As [Last successful scan],
  Case
    When Chrome.softID Is Null Then '-'
    Else 'Installed'
  End As Chrome,
  Case
    When Edge.softID Is Null Then '-'
    Else 'Installed'
  End As Edge,
  Case
    When FireFox.softID Is Null Then '-'
    Else 'Installed'
  End As Firefox,
  Case
    When Opera.softID Is Null Then '-'
    Else 'Installed'
  End As Opera,
  Case
    When Safari.softID Is Null Then '-'
    Else 'Installed'
  End As Safari,
  FireFox.softwareVersion As [Firefox Version],
  Chrome.softwareVersion As [Chrome Version],
  Safari.softwareVersion As [Safari Version],
  Opera.softwareVersion As [Opera Version],
  Edge.softwareVersion As [Edge Version]
From tblAssets
  Left Outer Join tsysOS On tsysOS.OScode = tblAssets.OScode
  Inner Join tblAssetCustom On tblAssets.AssetID = tblAssetCustom.AssetID
  Inner Join tsysAssetTypes On tsysAssetTypes.AssetType = tblAssets.Assettype
  Inner Join tsysIPLocations On tsysIPLocations.LocationID =
      tblAssets.LocationID
  Inner Join tblState On tblState.State = tblAssetCustom.State
  Left Outer Join (Select tblSoftware.AssetID,
      tblSoftware.softID,
      tblSoftware.softwareVersion
    From tblSoftware
      Inner Join tblSoftwareUni On tblSoftwareUni.SoftID = tblSoftware.softID
    Where tblSoftwareUni.softwareName Like '%Mozilla Firefox%') As FireFox On
      FireFox.AssetID = tblAssets.AssetID
  Left Outer Join (Select tblSoftware.AssetID,
      tblSoftware.softID,
      tblSoftware.softwareVersion
    From tblSoftware
      Inner Join tblSoftwareUni On tblSoftwareUni.SoftID = tblSoftware.softID
    Where tblSoftwareUni.softwareName Like '%Google Chrome%') As Chrome On
      Chrome.AssetID = tblAssets.AssetID
  Left Outer Join (Select tblSoftware.AssetID,
      tblSoftware.softID,
      tblSoftware.softwareVersion
    From tblSoftware
      Inner Join tblSoftwareUni On tblSoftwareUni.SoftID = tblSoftware.softID
    Where tblSoftwareUni.softwareName Like '%Safari%') As Safari On
      Safari.AssetID = tblAssets.AssetID
  Left Outer Join (Select tblSoftware.AssetID,
      tblSoftware.softID,
      tblSoftware.softwareVersion
    From tblSoftware
      Inner Join tblSoftwareUni On tblSoftwareUni.SoftID = tblSoftware.softID
    Where tblSoftwareUni.softwareName Like 'Opera%') As Opera On
      Opera.AssetID = tblAssets.AssetID
  Left Outer Join (Select tblSoftware.AssetID,
      tblSoftware.softID,
      tblSoftware.softwareVersion
    From tblSoftware
      Inner Join tblSoftwareUni On tblSoftwareUni.SoftID = tblSoftware.softID
    Where tblSoftwareUni.softwareName Like 'Microsoft Edge%') As Edge On
      Edge.AssetID = tblAssets.AssetID
  Left Join (Select Max(tblIndirectScan.LastChanged) As lastIndirectScan,
      tblIndirectScan.AssetId
    From tblIndirectScan
    Group By tblIndirectScan.AssetId) indirect On tblAssetCustom.AssetId =
      indirect.AssetId
Where tblState.Statename = 'Active' And tsysAssetTypes.AssetTypename In
  ('Windows', 'Windows CE')
Order By tblAssets.AssetName
