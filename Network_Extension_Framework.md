Network Extension Framework
Network Filtering - “Content Filter API’s”
Filter at the system level
NEFilterManager: Used to create a content filter config that registers content filter w/system so system knows how to run your content filter. 
You also create a system extenstion and this is where your code that actually filters network content will run. 
Content can be filtered at two different layers: flow layer or packet layer. 
Flow layer filtering: 
NEFilterDataProvider class;
- Gives read only access to flows
- By default system will pass any flow of tcp and udp data NEFilterDataProvider subclass
NEFilterSettings;
- Can be used to tell the system which flows to pass to your filter. 
Create a subclass of NEFilterDataProvider
Once content filter config is registered w/system & running;
New TCP & UDP flow of network data created on the system
they are passed to your NEFilterDataProvider subclass
they are represented as individual NEFilterFlow objects.
Your subclass allows or drops each individual flow. 
This decision can be made during any lifecycle stage of the flow;
up front or after having seen some of flows data. 

Packet Layer Filtering;
NEFilterPacketProvider;
Create subclass of NEFilterPacketProvider in your system extension. 
System will pass packet objects to your NEFilterPacketProvider subclass 
Subclass makes per packet allow/drop decisions. 

Filter at the packet level 
NEFilterPacketProvider


Transparent Proxy
Diverts traffic destined for a specific website to a cloud service. 
Can apply encryption, cacheing, multiplex (multiple flows of network traffic over a single connection) 
NETransparentProxyManager
Used to create transparent proxy app configs and register them with the system
Allows you to proxy flows of network data at the flow layer;
NEAppProxyProvider; 
- create subclass to proxy flows of network data at flow layer
- By default system does not divert flows to your proxy
- Handles flow diversion
NENetworkRule: 
- Specify what flow you want to proxy

NEProxySettings
NEDNSProxyProviderProtocol
@property providerConfiguration

NEDNSOverHTTPSSettings : NEDNSSettings
@property serverURL

NEDNSSettingsManager : NSObject {}
@method sharedManager
@return The singleton NEDNSSettingsManager object for the calling process

open func loadFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)
@method loadFromPreferencesWithCompletionHandler:
@discussion This function loads the current DNS settings configuration from the caller's DNS settings preferences.
@param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.

@available(macOS 11.0, *)
open func loadFromPreferences() async throws
@method removeFromPreferencesWithCompletionHandler:
@discussion This function removes the DNS settings configuration from the caller's DNS settings preferences. If the DNS settings are enabled, the DNS settings becomes disabled.
@param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.

    @available(macOS 11.0, *)
open func removeFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)
@method removeFromPreferencesWithCompletionHandler:
@discussion This function removes the DNS settings configuration from the caller's DNS settings preferences. If the DNS settings are enabled, the DNS settings becomes disabled.
@param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.



DNS Proxy
API’s that are part of the NetworkExtension Framework
- Applies additional security to the DNS protocol
    - App may 
        - Apply some encryption to DNS traffic
        - Proxy DNS traffic over some sort of secure channel
NEDNSProxyManager;
- Used in main app to 
    - Create DNS proxy configuration.
    - Register config w/system so system knows how to run your DNS proxy

NEDNSProxyProvider;
- Implement app proxy as subclass of this class.
- Once registered w/the system and your system extension is running
    - System will start diverting all dns queries to your NEDNSProxyProvider subclass. 
    - After this is is up to you how you would like to handle each DNS query
        - Encrypt it
        - Send over some sort of secure channel
        - etc.
Implement as subclass of NEDNSProxyProvider class

VPN
Part of the NetworkExtension Famework
NETunnelProviderManager;
- Use to create VPN configs and register VPN client w/the system. 
- Creates vpn extension and registers with system 
NEPacketTunnelProvider;
- Implement vpn client as subclass of this class
- System creates utun if corresponding to your NEPacketTunnelProvider
- Responsible for telling the system about which networks you want to be routed through your vpn. 
Once you’ve specified your routing rules for your vpn and those are installed in the system
- As ip packets are routed to your utun if per those routes
    - Those packets are diverted to your NEPacketTunnelProvider
        - You can send those packets thru your utun connection using your custom tunneling protocol

VPN API Enhancements (Catalina)
IncludeAllNetworks: Keeps all traffic in VPN. Drops traffic if network disconnects from VPN. 
excludeLocalNetworks: Allows local traffic to still occur

Per-App VPN 
MailDomains, CalendarDomains, ContactsDomains 
System Domains you can use to route traffic to your per app vpn
If Host connects to domain domain matches list traffic goes through vpn 
Specify work email domain in mail domain array to route work email through vpn when mail opens new connection to corporate email server that connection is routed through the per app vpn. 

Virtual Machine app extensions
vmnet.framework
Allows you to connect a virtual machine to the network 
Bridged Mode: Machines show up on the local network as if they were physically connected to the local network.

Apps that use Custom Protocols (Custom low-layer protocols)
comms w/ext if’s using low level or highly optimized protocols 
Custom IP Protocol: api 
IN app create new kind of NWParameters specifying identifier number for your custom IP protocol; 
Use that NWParameters object to creaet an NWConnection 
Use that NWConnection just as you would a tcp or udp connection to communicate over the network using your custom protocol 

 
￼

Cutom Link Layer Protocol
NWEthernetChannel: Object created in app specifying custom ether type to use. Use to com over eth if. 
(Must use custom ether type)
Set up NWEthernetChannel object; 

Set up Callback blocks; 

Network Kernel Extensions were deprecated as of MacOS Catelina
Kernel Extensions (Framework)
Uses the IOKit Framework
A kernel extension (kext) supports any low-level services that cannot be implemented using a dext or system extension.
- Only supported language for KEXT development is C and C++
- When a kernal extension load it becomes part of the kernal and has access to everything on the machine.
MacOS 10.15 will be the last release to fully support kexts without compromises
“Install a Kernel Extension only on Mojave or earlier”
DriverKit extension was introduced as of MacOS Catalina

Overview
A kernel extension (or kext) is a bundle that performs low-level tasks. Kexts run in kernel space, which gives them elevated privileges and the ability to perform tasks that user-space apps can’t.
Always consider alternatives before creating a kext. The system provides numerous APIs to minimize the need for kexts. For example, you can use the DriverKit SDK to implement drivers for most types of hardware. In addition, the kernel runtime environment has more stringent code-level requirements, which makes the creation of kexts more challenging, and the consequences more severe if you do it incorrectly.
For information about alternatives to kexts, see Implementing drivers, system extensions, and kexts.

Note ✏️
In macOS 11 and later, kmutil replaces kextload, kextunload, and other earlier tools for loading and managing kexts. The older tools still work, but their implementations now call kmutil.

Unload a Kernel Extension
Unloading a kext on macOS 11 and later requires a call to kmutil or kextunload, followed by a system reboot. The kmutil tool builds a new kext collection without the specified kext, but it doesn’t install that collection immediately. The system installs the new kext collection only after the computer reboots. As a result, the unloaded kext actually remains active and running until the user reboots the system.
For more details, see the kmutil(8) man page.

Use the DriverKit SDK and System Extensions framework to implement low-level services whenever possible. Drivers and system extensions run in user space, instead of inside the kernel’s process space. Running in user space improves system stability and makes it easier to develop, debug, and install your code

IOKit Classes
IOService
- Lifecycle methods; Start, Stop, Terminate
- Every service uses DispatchQueue 
    - DispatchQueue 
        - methods; Interrupts, timers, completions.
IOMemoryDescriptor
IOBufferMemoryDescriptor
IOWorkLoop
- Uses block api
EventSource



Tools
IOReg;
- Use to see kernel extensions

KERNAL; Class is defined in kernal;
LOCAL: Method is implemented in user driver
￼
Lifecycle
1. IOKit  matching creating a kernal service to match your service

