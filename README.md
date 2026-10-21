# Lansweeper Reports for Cyber Essentials
A collection of SQL queries for Lansweeper to help capture data for the UK National Cyber Security Centre Cyber Essentials self assessment

# Built-in reports that can assist reporting
* Assets > Asset types > ESXi server

# Extra configuration required for the Windows Firewall Status scan
To use this report you will need to add custom registry scanning to detect the status of the Windows Firewall (the data isn’t already captured by Lansweeper).

To add the attributes from the web management console go to Scanning > File & registry scanning > Add Registry Scan.

For the HKEY_LOCAL_MACHINE monitor the following attributes:

| Regpath                                                    | Regvalue       |
| ---------------------------------------------------------- | -------------- |
| SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile  | EnableFirewall |
| SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile | EnableFirewall |
| SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile  | EnableFirewall |
