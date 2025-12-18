import Foundation

@available(macOS 10.15, *)
public let OSSystemExtensionErrorDomain: String

/**
 @brief A property of a Driver Extension bundle containing a message that tells
 the user why the app is requesting to install it.

 @discussion The 'OSBundleUsageDescription' key is required in your Driver
 Extension if your app uses APIs that install them.
 */
@available(macOS 10.15, *)
public let OSBundleUsageDescriptionKey: String

/**
 @brief A property of a System Extension bundle containing a message that tells
 the user why the app is requesting to install it.

 @discussion The 'NSSystemExtensionUsageDescription' key is required in your
 System Extension if your app uses APIs that install them.
 */
@available(macOS 10.15, *)
public let NSSystemExtensionUsageDescriptionKey: String

/**
 @brief An optional property of a System Extension bundle naming the bundle
 identifier of a kernel extension (kext) with similar purpose and capabilities.

 @discussion The 'OSRelatedKernelExtension' key is optional. If one is present
 and the related kernel extension has the same Team ID and is approved by the
 system policy, this System Extension is also approved.
 */
@available(macOS 12.0, *)
public let OSRelatedKernelExtensionKey: String

@available(macOS 10.15, *)
public struct OSSystemExtensionError : CustomNSError, Hashable, Error {

    public init(_nsError: NSError)

    public static var errorDomain: String { get }

    @available(macOS 10.15, *)
    public enum Code : Int, @unchecked Sendable, Equatable {

        public typealias _ErrorType = OSSystemExtensionError

        case unknown = 1

        case missingEntitlement = 2

        case unsupportedParentBundleLocation = 3

        case extensionNotFound = 4

        case extensionMissingIdentifier = 5

        case duplicateExtensionIdentifer = 6

        case unknownExtensionCategory = 7

        case codeSignatureInvalid = 8

        case validationFailed = 9

        case forbiddenBySystemPolicy = 10

        case requestCanceled = 11

        case requestSuperseded = 12

        case authorizationRequired = 13
    }

    public static var unknown: OSSystemExtensionError.Code { get }

    public static var missingEntitlement: OSSystemExtensionError.Code { get }

    public static var unsupportedParentBundleLocation: OSSystemExtensionError.Code { get }

    public static var extensionNotFound: OSSystemExtensionError.Code { get }

    public static var extensionMissingIdentifier: OSSystemExtensionError.Code { get }

    public static var duplicateExtensionIdentifer: OSSystemExtensionError.Code { get }

    public static var unknownExtensionCategory: OSSystemExtensionError.Code { get }

    public static var codeSignatureInvalid: OSSystemExtensionError.Code { get }

    public static var validationFailed: OSSystemExtensionError.Code { get }

    public static var forbiddenBySystemPolicy: OSSystemExtensionError.Code { get }

    public static var requestCanceled: OSSystemExtensionError.Code { get }

    public static var requestSuperseded: OSSystemExtensionError.Code { get }

    public static var authorizationRequired: OSSystemExtensionError.Code { get }
}

extension OSSystemExtensionRequest {

    @available(macOS 10.15, *)
    public enum ReplacementAction : Int, @unchecked Sendable {

        /// Returned by the delegate when it determines that replacing an existing
        /// System Extension should not proceed.
        case cancel = 0

        /// Returned by the delegate when it determines that replacing an existing
        /// System Extension is desired.
        case replace = 1
    }

    /// Describes additional result feedback after completion of a system extension request
    @available(macOS 10.15, *)
    public enum Result : Int, @unchecked Sendable {

        /// The request was successfully completed.
        case completed = 0

        /// The request will be successfully completed after a reboot.
        case willCompleteAfterReboot = 1
    }
}

@available(macOS 10.15, *)
open class OSSystemExtensionRequest : NSObject {

    /**
     @brief Creates a request to activate a System Extension.
    
     @discussion This method creates a new request to activate a System Extension.
     Extensions are bundles discovered from the `Contents/Library/SystemExtensions`
     directory of the main application bundle.
    
     @param identifier The bundle identifier of the target extension.
    
     @param queue The dispatch queue to use when calling delegate methods.
    
     @return A new extension request.
    
     @note It is expected that an application create and submit an activation
     request whenever an extension should be active. Upon submitting an activation
     request for an inactive extension, user approval may be required and the
     request will not succeed until approval is given.
    
     If the extension is already active then the request will succeed in short
     order without significant delay or user interaction. Activating an new version
     of an already active extension will prompt the delegate to resolve the conflict
     before proceeding.
    
     An activation request can be successful but also indicate that a reboot is
     required in order for the extension to become active. This can occur when
     replacing an existing extension that required a reboot in order to deactivate.
     The most recently activated extension will then become active when the system
     is next rebooted.
     */
    @available(macOS 10.15, *)
    open class func activationRequest(forExtensionWithIdentifier identifier: String, queue: dispatch_queue_t) -> Self

    /**
     @brief Creates a request to deactivate a System Extension.
    
     @discussion This method creates a new request to deactivate a System Extension.
     Extensions are discovered from the `Contents/Library/SystemExtensions`
     directory of the main application bundle.
    
     @param identifier The bundle identifier of the target extension.
    
     @param queue The dispatch queue to use when calling delegate methods.
    
     @note It is possible for an extension to require a reboot before it is fully
     deactivated. If a request succeeds and indicates a reboot is required, the
     extension may still appear to be operational until that time.
     */
    @available(macOS 10.15, *)
    open class func deactivationRequest(forExtensionWithIdentifier identifier: String, queue: dispatch_queue_t) -> Self

    /**
     @brief Creates a request to get information about System Extensions.
    
     @discussion This method creates a new request to retrieve the properties
     of any System Extensions matching the given identifier.
    
     @param identifier The bundle identifier of the target extension(s).
    
     @param queue The dispatch queue to use when calling delegate methods.
     */
    @available(macOS 12.0, *)
    open class func propertiesRequest(forExtensionWithIdentifier identifier: String, queue: dispatch_queue_t) -> Self

    /**
     @brief A delegate to receive updates about the progress of a request
     */
    @available(macOS 10.15, *)
    weak open var delegate: (any OSSystemExtensionRequestDelegate)?

    /**
     @brief The bundle identifier of the target extension
     */
    @available(macOS 10.15, *)
    open var identifier: String { get }
}

@available(macOS 10.15, *)
open class OSSystemExtensionProperties : NSObject {

    /**
     @brief The file URL locating an indicating the extension bundle these properties
     were retreived from.
     */
    @available(macOS 10.15, *)
    open var url: URL { get }

    /**
     @brief The bundle identifier of the extension (CFBundleIdentifier)
     */
    @available(macOS 10.15, *)
    open var bundleIdentifier: String { get }

    /**
     @brief The bundle version of the extension (CFBundleVersion)
     */
    @available(macOS 10.15, *)
    open var bundleVersion: String { get }

    /**
     @brief The bundle short version string of the extension (CFBundleShortVersionString)
     */
    @available(macOS 10.15, *)
    open var bundleShortVersion: String { get }

    /**
     @brief Returns the enabled state of the extension
     */
    @available(macOS 12.0, *)
    open var isEnabled: Bool { get }

    /**
     @brief Returns whether an extension is waiting for user approval
     */
    @available(macOS 12.0, *)
    open var isAwaitingUserApproval: Bool { get }

    /**
     @brief Returns if an extension is being uninstalled
     */
    @available(macOS 12.0, *)
    open var isUninstalling: Bool { get }
}

@available(macOS 10.15, *)
public protocol OSSystemExtensionRequestDelegate : NSObjectProtocol {

    /**
     @brief Called when the target extension bundle identifier is already activated.
    
     @discussion The delegate will receive this callback when an activation request
     encounters an existing extension with the same team and bundle identifiers but
     with different version identifiers. The delegate must make a decision on
     whether or not to replace the existing extension.
    
     @param request The request that encountered the conflict
    
     @param existing The NSBundle of the existing extension
    
     @param ext The NSBundle of the extension matching the bundle identifier of the request
    
     @return A replacement action indicating the desired outcome of the conflict
    
     @note This method is invoked if the `CFBundleVersion` or `CFBundleShortVersionString`
     identifiers of the target and existing extension differ.
    
     If the local system has System Extension developer mode enabled, this callback
     will always fire when an existing extension is found, regardless of version
     identifiers.
    
     Returning OSSystemExtensionReplacementActionAbortRequest will trigger a callback
     to `request:didFailWithError:` with the OSSystemExtensionErrorRequestCanceled
     error code.
     */
    @available(macOS 10.15, *)
    func request(_ request: OSSystemExtensionRequest, actionForReplacingExtension existing: OSSystemExtensionProperties, withExtension ext: OSSystemExtensionProperties) -> OSSystemExtensionRequest.ReplacementAction

    /**
     @brief Called when the target extension requires user approval to be activated.
    
     @discussion Activating an extension may require explicit user approval in order
     to proceed. For example, this can occur when the user has never previously
     approved this extension. If approval is necessary, this callback will be
     triggered and the activation request will remain pending until user approves,
     or until the application exits.
     */
    @available(macOS 10.15, *)
    func requestNeedsUserApproval(_ request: OSSystemExtensionRequest)

    /**
     @brief Called when the target extension request has completed.
    
     @discussion Successful results can come with additional information regarding
     the manner in which they were completed. See the OSSystemExtensionRequestResult
     documentation for more information.
    
     @param result Additional result information from the completed request.
    
     @note If the request completes with the `OSSystemExtensionRequestWillCompleteAfterReboot`
     result, then the extension will not be active until after the next reboot. Upon
     reboot, a given extension will be in the state dictated by the most recently
     processed request.
     */
    @available(macOS 10.15, *)
    func request(_ request: OSSystemExtensionRequest, didFinishWithResult result: OSSystemExtensionRequest.Result)

    /**
     @abstract Called when the target extension request failed.
     */
    @available(macOS 10.15, *)
    func request(_ request: OSSystemExtensionRequest, didFailWithError error: any Error)

    /**
     @brief Called request for properties has completed.
    
     @param properties Returns an array of OSSystemExtensionProperties matching the
     requested bundle identifier.
     */
    @available(macOS 12.0, *)
    optional func request(_ request: OSSystemExtensionRequest, foundProperties properties: [OSSystemExtensionProperties])
}

@available(macOS 10.15, *)
open class OSSystemExtensionManager : NSObject {

    @available(macOS 10.15, *)
    open class var shared: OSSystemExtensionManager { get }

    /**
     @abstract Submits a System Extension request to the manager.
    
     @param request The request to process.
     */
    @available(macOS 10.15, *)
    open func submitRequest(_ request: OSSystemExtensionRequest)
}

@available(macOS 15.1, *)
open class OSSystemExtensionInfo : NSObject, @unchecked Sendable {

    /**
     @brief The bundle identifier of the extension (CFBundleIdentifier)
     */
    open var bundleIdentifier: String { get }

    /**
     @brief The bundle version of the extension (CFBundleVersion)
     */
    open var bundleVersion: String { get }

    /**
     @brief The bundle short version string of the extension (CFBundleShortVersionString)
     */
    open var bundleShortVersion: String { get }
}

@available(macOS 15.1, *)
public protocol OSSystemExtensionsWorkspaceObserver : NSObjectProtocol {

    /**
     @brief This delegate method will be called when a system extension has been validated and allowed by the user to run.
     */
    optional func systemExtensionWillBecomeEnabled(_ systemExtensionInfo: OSSystemExtensionInfo)

    /**
     @brief This delegate method will be called when the user disables an already enabled system extension, or when the system extension is first installed and is in the disabled state.
     */
    optional func systemExtensionWillBecomeDisabled(_ systemExtensionInfo: OSSystemExtensionInfo)

    /**
     @brief This delegate method will be called when a system extension is deactivated and is about to get uninstalled. The extension may still be running until the system is rebooted.
     */
    optional func systemExtensionWillBecomeInactive(_ systemExtensionInfo: OSSystemExtensionInfo)
}

/**
 @note Using the workspace API requires the system extension entitlement
 */
@available(macOS 15.1, *)
open class OSSystemExtensionsWorkspace : NSObject, @unchecked Sendable {

    open class var shared: OSSystemExtensionsWorkspace { get }

    /**
     @brief Start observing changes to System Extension(s) which are enabled or ready to be enabled.
     */
    open func addObserver(_ observer: any OSSystemExtensionsWorkspaceObserver) throws

    /**
     @brief Stop observing changes to System Extension(s).
     */
    open func removeObserver(_ observer: any OSSystemExtensionsWorkspaceObserver)
}


