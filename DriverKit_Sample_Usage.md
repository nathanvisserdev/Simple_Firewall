XCode DriverKit Project

- Create new project
- Select macOS > DriverKit Driver (search if needed)
- Supposed to inslude entitlements by default
- .iig file; class definition for driver
￼
kern_return_t Start & Stop; IOKit Lifecycle methods

IOUSBHostPipe;
- Protocol that DriverKit callbacks MUST conform to.
- All instance variables must be allocated by the driver at time of initialization 

1. Declare struct to hold all instance vars;
￼
- Include all instance vars you would’ve included in the kernel class b4
- Same USB kernel types as Kext
    - IOUSBHostInterface provider
    - IOUSBHostPipe object 
        - Performs IO
    - OSAction object
        - “Encapsulated” Async callbacks (IO)
- Allocate at init

init “routine”;
￼
- Calls init on superclass same as Kext
- Allocates struct 

Start implementation;
￼
- Calls into superclass and validates provider
- “Slightly different” then kernel implementation…
- IMPL; Required to support user process > kernel proxy object IPC
- Start; kext called superstart 


USB DriverKit API;
￼

Allocate OS attribute object to encapsulate the callback;
￼

Testing the app;
￼
- ps -ax | grep -i myuser
    - Shows the driver is running
    - PID is 2572
- sudo lldb
    - lldb will show what’s happening in the driver
- process attach —pid 2572
    - Attach to the target process 

￼
- thread list
    - Find the thread running the readComplete method
    - We can see that it is thread #2
- thread select 2
    - Select thread #2
    - Shows an infinite loop is occuring
    - Shows a de-referenced null pointer that would crash the driver
    - Shows the driver crashed but restarted w/out effecting the rest of the system
- expression loop = false
    - Modify loop variable 
        - Only able to do this in user space not kext
- detach
    - detaches lldb from the process

On unplug you can see that your stop and free methods run as normal
￼

