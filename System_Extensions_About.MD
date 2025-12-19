System Extension
A system extension implements features that require kernel-level cooperation, such as custom security and network behaviors.

Three Types os System Extensions you can build;
1. Network Extensions
2. Driver Extensions
3. Endpoint Security Extensions

1. Network Extensions;
- Replacement of network kernel extensions
- Capabilities include;
    - Content filter
    - DNS Proxy
    - VPN client

2. Driver Extensions;
- A replacement for device-driver kexts that used IOKit
- Control
    - USB
    - Serial
    - NIC (Network Interface Controller)
    - HID (Human Interface Device)
- Must be written in C or C++ (default is C++ 17)
DriverKit;
- Driver extensions are built with DriverKit
- New SDK w/All New frameworks as of Catalina
- Based on IOKit but “Updated” and “Modernized”
- Designed for building Driver extensions in user space
- DriverKit interfaces use a new file type with a .iig extension
NetworkingDriverKit;
- Used for creating network interfaces
HIDDriverKit;
- Used for creating HID devices
USBSerialDriverKit
- Used to make USB serial device available to the OS
USB DriverKit
- Used to make use of USB device providers in your driverd. 
Driver Extension Security
Entitlements needed
- com.apple.developer.driverkit: For all driver extensions entitlement.
- com.apple.developer.driverkit.transport.usb
    - Attach to a device (transport eneitlement, specific to device type)
    - Transport entitlement; to take control of a device
- com.apple.developer.driverkit.family.hid.device
    - Provide service to the OS (Family entitlement)

Driver Extension Compatibility
MacOS 10.15 will be the last release to fully support kexts without compromises
“Install a Kernel Extension only on Mojave or earlier”
DriverKit extension was introduced as of MacOS Catalina


3. Endpoint Security Extensions;
- Replacement for kexts (kauth) to monitor security-related events. 
- Apps you can build
    - Endpoint Detection & Response
    - Anti-virus
    - Data Loss Prevention

