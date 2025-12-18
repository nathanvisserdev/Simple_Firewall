import ExtensionFoundation
import Foundation
import Network
import Security

@available(macOS 10.11, *)
public struct NEAppProxyFlowError : CustomNSError, Hashable, Error {

    public init(_nsError: NSError)

    public static var errorDomain: String { get }

    /**
     * @typedef NEAppProxyFlowError
     * @abstract Flow error codes
     */
    @available(macOS 10.11, *)
    public enum Code : Int, @unchecked Sendable, Equatable {

        /**
         * @typedef NEAppProxyFlowError
         * @abstract Flow error codes
         */
        public typealias _ErrorType = NEAppProxyFlowError

        /** @const NEAppProxyFlowErrorNotOpen The flow is not fully open. */
        case notConnected = 1

        /** @const NEAppProxyFlowErrorPeerReset The remote peer reset the flow. */
        case peerReset = 2

        /** @const NEAppProxyFlowErrorHostUnreachable The remote peer is unreachable. */
        case hostUnreachable = 3

        /** @const NEAppProxyFlowErrorInvalidArgument An invalid argument was passed to one of the NEAppProxyFlow methods. */
        case invalidArgument = 4

        /** @const NEAppProxyFlowErrorAborted The flow was aborted. */
        case aborted = 5

        /** @const NEAppProxyFlowErrorRefused The flow was disallowed. */
        case refused = 6

        /** @const NEAppProxyFlowErrorTimedOut The flow timed out. */
        case timedOut = 7

        /** @const NEAppProxyFlowErrorInternal An internal error occurred. */
        case `internal` = 8

        /** @const NEAppProxyFlowErrorDatagramTooLarge An attempt was made to write a datagram that is larger than the socket's receive window */
        @available(macOS 10.11, *)
        case datagramTooLarge = 9

        /** @const NEAppProxyFlowErrorReadAlreadyPending A read operation on the flow is already pending */
        @available(macOS 10.11, *)
        case readAlreadyPending = 10
    }

    /** @const NEAppProxyFlowErrorNotOpen The flow is not fully open. */
    public static var notConnected: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorPeerReset The remote peer reset the flow. */
    public static var peerReset: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorHostUnreachable The remote peer is unreachable. */
    public static var hostUnreachable: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorInvalidArgument An invalid argument was passed to one of the NEAppProxyFlow methods. */
    public static var invalidArgument: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorAborted The flow was aborted. */
    public static var aborted: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorRefused The flow was disallowed. */
    public static var refused: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorTimedOut The flow timed out. */
    public static var timedOut: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorInternal An internal error occurred. */
    public static var `internal`: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorDatagramTooLarge An attempt was made to write a datagram that is larger than the socket's receive window */
    @available(macOS 10.11, *)
    public static var datagramTooLarge: NEAppProxyFlowError.Code { get }

    /** @const NEAppProxyFlowErrorReadAlreadyPending A read operation on the flow is already pending */
    @available(macOS 10.11, *)
    public static var readAlreadyPending: NEAppProxyFlowError.Code { get }
}

/** @const NEAppProxyErrorDomain The NEAppProxyFlow error domain */
@available(macOS 10.11, *)
public let NEAppProxyErrorDomain: String

/**
 * @interface NEAppProxyFlow
 * @discussion The NEAppProxyFlow class is an abstract base class that declares the programmatic interface for a flow of network data.
 *
 * NEAppProxyFlow is part of NetworkExtension.framework.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEAppProxyFlow : NSObject {

    /**
     * @method openWithLocalEndpoint:completionHandler:
     * @discussion This function is used by an NEProvider implementation to indicate that it is ready to handle flow data.
     * @param localEndpoint The address and port that should be used as the local endpoint of the socket associated with this flow. If the source application already specified a local endpoint by binding the socket then this parameter is ignored.
     * @param completionHandler A block that is called when the process of opening flow is complete. A nil value passed to this block indicates that the flow was opened successfully. A non-nil NSError value indicates that the flow failed to open successfully.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open func open(withLocalEndpoint localEndpoint: NWHostEndpoint?, completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method openWithLocalEndpoint:completionHandler:
     * @discussion This function is used by an NEProvider implementation to indicate that it is ready to handle flow data.
     * @param localEndpoint The address and port that should be used as the local endpoint of the socket associated with this flow. If the source application already specified a local endpoint by binding the socket then this parameter is ignored.
     * @param completionHandler A block that is called when the process of opening flow is complete. A nil value passed to this block indicates that the flow was opened successfully. A non-nil NSError value indicates that the flow failed to open successfully.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open func open(withLocalEndpoint localEndpoint: NWHostEndpoint?) async throws

    /**
     * @method closeReadWithError:
     * @discussion This function is used by an NEProvider implementation to indicate that it does not want to receive any more data from the flow.
     * @param error An error in NEAppProxyErrorDomain that should be passed to the flow's source application.
     */
    @available(macOS 10.11, *)
    open func closeReadWithError(_ error: (any Error)?)

    /**
     * @method closeWriteWithError:
     * @discussion This functions is used by an NEProvider implementation to indicate that it does not have any more data to write to the flow.
     * @param error An error in NEAppProxyErrorDomain that should be passed to the flow's source application.
     */
    @available(macOS 10.11, *)
    open func closeWriteWithError(_ error: (any Error)?)

    /**
     * @method setMetadata:
     * @discussion Set the flow's NEFlowMetaData object in an nw_parameters_t object. The nw_parameters_t object can then be used to create a connection that transparently proxies the flow's
     *     data, and provides accurate source app information to any subsequent NEAppProxyProvider instances that transparently proxy the flow.
     * @param parameters An nw_parameters_t object.
     */
    @available(macOS 10.15.4, *)
    open func setMetadata(_ parameters: nw_parameters_t)

    /**
     * @property metaData
     * @discussion An NEFlowMetaData object containing meta data for the flow.
     */
    @available(macOS 10.11, *)
    open var metaData: NEFlowMetaData { get }

    /**
     * @property networkInterface
     * @discussion An nw_interface_t containing information about the network interface used by the flow. If the flow's data is transported using a different interface, this property
     *    should be set to that interface.
     */
    @available(macOS 10.15.4, *)
    @NSCopying open var networkInterface: nw_interface_t?

    /**
     * @property remoteHostname
     * @discussion If the flow was created by passing a hostname to a "connect by name" API such as NSURLSession or Network.framework, this property is set to the
     *     remote hostname.
     */
    @available(macOS 11.0, *)
    open var remoteHostname: String? { get }

    /**
     * @property isBound
     * @discussion YES if the flow was bound by the application to a specific interface (contained in the networkInterface property), NO otherwise.
     */
    @available(macOS 11.1, *)
    open var isBound: Bool { get }
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEAppProxyFlow {

    /// This function is used by an NEProvider implementation to indicate that it is ready to handle flow data.
    /// - Parameters:
    ///   - localEndpoint: The address and port that should be used as the local endpoint of the socket associated with this flow. If the source application already specified a local endpoint by binding the socket then this parameter is ignored.
    ///   - completionHandler: A block that is called when the process of opening flow is complete. A nil value passed to this block indicates that the flow was opened successfully. A non-nil NSError value indicates that the flow failed to open successfully.
    public func open(withLocalFlowEndpoint localEndpoint: NWEndpoint?, completionHandler: @escaping ((any Error)?) -> Void)

    /// This function is used by an NEProvider implementation to indicate that it is ready to handle flow data.
    /// - Parameter localEndpoint: The address and port that should be used as the local endpoint of the socket associated with this flow. If the source application already specified a local endpoint by binding the socket then this parameter is ignored.
    public func open(withLocalFlowEndpoint localEndpoint: NWEndpoint?) async throws

    /// Set the flow's NEFlowMetaData object in an NWParameters object. The NWParameters object can then be used to create a connection that transparently proxies the flow's data, and provides accurate source app information to any subsequent NEAppProxyProvider instances that transparently proxy the flow.
    /// - Parameter parameters: An NWParameters object.
    public func setMetadata(on parameters: NWParameters)

    /// An NWInterface containing information about the network interface used by the flow.
    ///
    /// If the flow's data is transported using a different interface, this property should be set to that interface.
    public var interface: NWInterface?
}

/**
 * @typedef NEProviderStopReason
 * @abstract Provider stop reasons
 */
@available(macOS 10.11, *)
public enum NEProviderStopReason : Int, @unchecked Sendable {

    /** @const NEProviderStopReasonNone No specific reason. */
    case none = 0

    /** @const NEProviderStopReasonUserInitiated The user stopped the provider. */
    case userInitiated = 1

    /** @const NEProviderStopReasonProviderFailed The provider failed. */
    case providerFailed = 2

    /** @const NEProviderStopReasonNoNetworkAvailable There is no network connectivity. */
    case noNetworkAvailable = 3

    /** @const NEProviderStopReasonUnrecoverableNetworkChange The device attached to a new network. */
    case unrecoverableNetworkChange = 4

    /** @const NEProviderStopReasonProviderDisabled The provider was disabled. */
    case providerDisabled = 5

    /** @const NEProviderStopReasonAuthenticationCanceled The authentication process was cancelled. */
    case authenticationCanceled = 6

    /** @const NEProviderStopReasonConfigurationFailed The provider could not be configured. */
    case configurationFailed = 7

    /** @const NEProviderStopReasonIdleTimeout The provider was idle for too long. */
    case idleTimeout = 8

    /** @const NEProviderStopReasonConfigurationDisabled The associated configuration was disabled. */
    case configurationDisabled = 9

    /** @const NEProviderStopReasonConfigurationRemoved The associated configuration was deleted. */
    case configurationRemoved = 10

    /** @const NEProviderStopReasonSuperceded A high-priority configuration was started. */
    case superceded = 11

    /** @const NEProviderStopReasonUserLogout The user logged out. */
    case userLogout = 12

    /** @const NEProviderStopReasonUserSwitch The active user changed. */
    case userSwitch = 13

    /** @const NEProviderStopReasonConnectionFailed Failed to establish connection. */
    case connectionFailed = 14

    /** @const NEProviderStopReasonSleep The device went to sleep and disconnectOnSleep is enabled in the configuration */
    @available(macOS 10.15, *)
    case sleep = 15

    /** @const NEProviderStopReasonAppUpdate The NEProvider is being updated */
    @available(macOS 10.15, *)
    case appUpdate = 16

    /** @const NEProviderStopReasonInternalError An internal error occurred in the NetworkExtension framework */
    @available(macOS 15.1, *)
    case internalError = 17
}

/**
 * @interface NEProvider
 * @discussion The NEProvider class declares the programmatic interface that is common for all Network Extension providers.
 *
 * See the sub classes of NEProvider for more details. Developers of Network Extension providers should create sub classes of the sub classes of NEProvider.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEProvider : NSObject {

    /**
     * @method sleepWithCompletionHandler:
     * @discussion This function is called by the framework when the system is about to go to sleep. Subclass developers can override this method to implement custom behavior such as closing connections or pausing some network activity.
     * @param completionHandler When the method is finished handling the sleep event it must execute this completion handler.
     */
    @available(macOS 10.11, *)
    open func sleep(completionHandler: @escaping @Sendable () -> Void)

    /**
     * @method sleepWithCompletionHandler:
     * @discussion This function is called by the framework when the system is about to go to sleep. Subclass developers can override this method to implement custom behavior such as closing connections or pausing some network activity.
     * @param completionHandler When the method is finished handling the sleep event it must execute this completion handler.
     */
    @available(macOS 10.11, *)
    open func sleep() async

    /**
     * @method wake
     * @discussion This function is called by the framework immediately after the system wakes up from sleep. Subclass developers can override this method to implement custom behavior such as re-establishing connections or resuming some network activity.
     */
    @available(macOS 10.11, *)
    open func wake()

    /**
     * @method createTCPConnectionToEndpoint:enableTLS:TLSParameters:delegate:
     * @discussion This function can be called by subclass implementations to create a TCP connection to a given network endpoint. This function should not be overridden by subclasses.
     * @param remoteEndpoint An NWEndpoint object that specifies the remote network endpoint to connect to.
     * @param enableTLS A flag indicating if a TLS session should be negotiated on the connection.
     * @param TLSParameters A set of optional TLS parameters. Only valid if enableTLS is YES. If TLSParameters is nil, the default system parameters will be used for TLS negotiation.
     * @param delegate An object to use as the connections delegate. This object should conform to the NWTCPConnectionAuthenticationDelegate protocol.
     * @return An NWTCPConnection object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use nw_connection_t in Network framework instead")
    open func createTCPConnection(to remoteEndpoint: NWEndpoint, enableTLS: Bool, tlsParameters TLSParameters: NWTLSParameters?, delegate: Any?) -> NWTCPConnection

    /**
     * @method createUDPSessionToEndpoint:fromEndpoint:
     * @discussion This function can be called by subclass implementations to create a UDP session between a local network endpoint and a remote network endpoint. This function should not be overridden by subclasses.
     * @param remoteEndpoint An NWEndpoint object that specifies the remote endpoint to which UDP datagrams will be sent by the UDP session.
     * @param localEndpoint An NWHostEndpoint object that specifies the local IP address endpoint to use as the source endpoint of the UDP session.
     * @return An NWUDPSession object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use nw_connection_t in Network framework instead")
    open func createUDPSession(to remoteEndpoint: NWEndpoint, from localEndpoint: NWHostEndpoint?) -> NWUDPSession

    /**
     * @method displayMessage:completionHandler:
     * @discussion This method can be called by subclass implementations to display a message to the user.
     * @param message The message to be displayed.
     * @param completionHandler A block that is executed when the user acknowledges the message. If this method is called on a NEFilterDataProvider instance or the message cannot be displayed, then the completion handler block will be executed immediately with success parameter set to NO. If the message was successfully displayed to the user, then the completion handler block is executed with the success parameter set to YES when the user dismisses the message.
     */
    @available(macOS, introduced: 10.12, deprecated: 10.14)
    open func displayMessage(_ message: String, completionHandler: @escaping @Sendable (Bool) -> Void)

    /**
     * @method startSystemExtensionMode
     * @discussion Start the Network Extension machinery in a system extension (.system bundle). This class method will cause the calling system extension to start handling
     *    requests from nesessionmanager to instantiate appropriate NEProvider sub-class instances. The system extension must declare a mapping of Network Extension extension points to
     *    NEProvider sub-class instances in its Info.plist:
     *        Key: NetworkExtension
     *        Type: Dictionary containing information about the NetworkExtension capabilities of the system extension.
     *
     *            Key: NEProviderClasses
     *            Type: Dictionary mapping NetworkExtension extension point identifiers to NEProvider sub-classes
     *
     *    Example:
     *
     *        <key>NetworkExtension</key>
     *        <dict>
     *            <key>NEProviderClasses</key>
     *            <dict>
     *                <key>com.apple.networkextension.app-proxy</key>
     *                <string>$(PRODUCT_MODULE_NAME).AppProxyProvider</string>
     *                <key>com.apple.networkextension.filter-data</key>
     *                <string>$(PRODUCT_MODULE_NAME).FilterDataProvider</string>
     *            </dict>
     *        </dict>
     *
     *    This method should be called as early as possible after the system extension starts.
     */
    @available(macOS 10.15, *)
    open class func startSystemExtensionMode()

    /**
     * @property defaultPath
     * @discussion The current default path for connections created by the provider. Use KVO to watch for network changes.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use nw_path_monitor_t in Network framework instead")
    open var defaultPath: NWPath? { get }
}

@available(macOS 10.11, *)
public struct NETunnelProviderError : CustomNSError, Hashable, Error {

    public init(_nsError: NSError)

    public static var errorDomain: String { get }

    /**
     * @typedef NETunnelProviderError
     * @abstract Tunnel Provider error codes
     */
    @available(macOS 10.11, *)
    public enum Code : Int, @unchecked Sendable, Equatable {

        /**
         * @typedef NETunnelProviderError
         * @abstract Tunnel Provider error codes
         */
        public typealias _ErrorType = NETunnelProviderError

        /** @const NETunnelProviderErrorNetworkSettingsInvalid The provided tunnel network settings are invalid. */
        case networkSettingsInvalid = 1

        /** @const NETunnelProviderErrorNetworkSettingsCanceled The request to set/clear the tunnel network settings was canceled. */
        case networkSettingsCanceled = 2

        /** @const NETunnelProviderErrorNetworkSettingsFailed The request to set/clear the tunnel network settings failed. */
        case networkSettingsFailed = 3
    }

    /** @const NETunnelProviderErrorNetworkSettingsInvalid The provided tunnel network settings are invalid. */
    public static var networkSettingsInvalid: NETunnelProviderError.Code { get }

    /** @const NETunnelProviderErrorNetworkSettingsCanceled The request to set/clear the tunnel network settings was canceled. */
    public static var networkSettingsCanceled: NETunnelProviderError.Code { get }

    /** @const NETunnelProviderErrorNetworkSettingsFailed The request to set/clear the tunnel network settings failed. */
    public static var networkSettingsFailed: NETunnelProviderError.Code { get }
}

/**
 * @typedef NETunnelProviderRoutingMethod
 * @abstract Network traffic routing methods.
 */
@available(macOS 10.11, *)
public enum NETunnelProviderRoutingMethod : Int, @unchecked Sendable {

    /** @const NETunnelProviderRoutingMethodDestinationIP Route network traffic to the tunnel based on destination IP */
    case destinationIP = 1

    /** @const NETunnelProviderRoutingMethodSourceApplication Route network traffic to the tunnel based on source application */
    case sourceApplication = 2

    /** @const NETunnelProviderRoutingMethodNetworkRule Route traffic to the tunnel (or proxy) based on NENetworkRule objects specified by the provider */
    @available(macOS 10.15, *)
    case networkRule = 3
}

/** @const NETunnelProviderErrorDomain The tunnel provider error domain */
@available(macOS 10.11, *)
public let NETunnelProviderErrorDomain: String

/**
 * @interface NETunnelProvider
 * @discussion The NETunnelProvider class declares the programmatic interface for an object that provides a network tunnel service.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NETunnelProvider : NEProvider {

    /**
     * @method handleAppMessage:completionHandler:
     * @discussion This function is called by the framework when the container app sends a message to the provider. Subclasses should override this method to handle the message and optionally send a response.
     * @param messageData An NSData object containing the message sent by the container app.
     * @param completionHandler A block that the method can execute to send a response to the container app. If this parameter is non-nil then the method implementation should always execute the block. If this parameter is nil then the method implementation should treat this as an indication that the container app is not expecting a response.
     */
    @available(macOS 10.11, *)
    open func handleAppMessage(_ messageData: Data, completionHandler: (@Sendable (Data?) -> Void)? = nil)

    /**
     * @method handleAppMessage:completionHandler:
     * @discussion This function is called by the framework when the container app sends a message to the provider. Subclasses should override this method to handle the message and optionally send a response.
     * @param messageData An NSData object containing the message sent by the container app.
     * @param completionHandler A block that the method can execute to send a response to the container app. If this parameter is non-nil then the method implementation should always execute the block. If this parameter is nil then the method implementation should treat this as an indication that the container app is not expecting a response.
     */
    @available(macOS 10.11, *)
    open func handleAppMessage(_ messageData: Data) async -> Data?

    /**
     * @method setTunnelNetworkSettings:completionHandler:
     * @discussion This function is called by tunnel provider implementations to set the network settings of the tunnel, including IP routes, DNS servers, and virtual interface addresses depending on the tunnel type. Subclasses should not override this method. This method can be called multiple times during the lifetime of a particular tunnel. It is not necessary to call this function with nil to clear out the existing settings before calling this function with a non-nil configuration.
     * @param tunnelNetworkSettings An NETunnelNetworkSettings object containing all of the desired network settings for the tunnel. Pass nil to clear out the current network settings.
     * @param completionHandler A block that will be called by the framework when the process of setting or clearing the network settings is complete. If an error occurred during the process of setting or clearing the IP network settings then a non-nill NSError object will be passed to this block containing error details.
     */
    @available(macOS 10.11, *)
    open func setTunnelNetworkSettings(_ tunnelNetworkSettings: NETunnelNetworkSettings?, completionHandler: (@Sendable ((any Error)?) -> Void)? = nil)

    /**
     * @method setTunnelNetworkSettings:completionHandler:
     * @discussion This function is called by tunnel provider implementations to set the network settings of the tunnel, including IP routes, DNS servers, and virtual interface addresses depending on the tunnel type. Subclasses should not override this method. This method can be called multiple times during the lifetime of a particular tunnel. It is not necessary to call this function with nil to clear out the existing settings before calling this function with a non-nil configuration.
     * @param tunnelNetworkSettings An NETunnelNetworkSettings object containing all of the desired network settings for the tunnel. Pass nil to clear out the current network settings.
     * @param completionHandler A block that will be called by the framework when the process of setting or clearing the network settings is complete. If an error occurred during the process of setting or clearing the IP network settings then a non-nill NSError object will be passed to this block containing error details.
     */
    @available(macOS 10.11, *)
    open func setTunnelNetworkSettings(_ tunnelNetworkSettings: NETunnelNetworkSettings?) async throws

    /**
     * @property protocolConfiguration
     * @discussion An NEVPNProtocol object containing the provider's current configuration. The value of this property may change during the lifetime of the tunnel provided by this NETunnelProvider, KVO can be used to detect when changes occur.  For different protocol types, this property will contain the corresponding subclass.   For NEVPNProtocolTypePlugin protocol type, this property will contain the NETunnelProviderProtocol subclass.  For NEVPNProtocolTypeIKEv2 protocol type, this property will contain the NEVPNProtocolIKEv2 subclass.
     */
    @available(macOS 10.11, *)
    open var protocolConfiguration: NEVPNProtocol { get }

    /**
     * @property appRules
     * @discussion An array of NEAppRule objects specifying which applications are currently being routed through the tunnel provided by this NETunnelProvider. If application-based routing is not enabled for the tunnel, then this property is set to nil.
     */
    @available(macOS 10.11, *)
    open var appRules: [NEAppRule]? { get }

    /**
     * @property routingMethod
     * @discussion The method by which network traffic is routed to the tunnel. The default is NETunnelProviderRoutingMethodDestinationIP.
     */
    @available(macOS 10.11, *)
    open var routingMethod: NETunnelProviderRoutingMethod { get }

    /**
     * @property reasserting
     * @discussion A flag that indicates to the framework if this NETunnelProvider is currently re-establishing the tunnel. Setting this flag will cause the session status visible to the user to change to "Reasserting". Clearing this flag will change the user-visible status of the session back to "Connected". Setting and clearing this flag only has an effect if the session is in the "Connected" state.
     */
    @available(macOS 10.11, *)
    open var reasserting: Bool
}

/**
 * @interface NEAppProxyProvider
 * @discussion The NEAppProxyProvider class declares the programmatic interface for an object that implements the client side of a custom network proxy solution.
 *
 * NEAppProxyProvider is part of NetworkExtension.framework
 */
@available(macOS 10.11, *)
open class NEAppProxyProvider : NETunnelProvider {

    /**
     * @method startProxyWithOptions:completionHandler:
     * @discussion This function is called by the framework when a new proxy instance is being created. Subclasses must override this method to perform whatever steps are necessary to ready the proxy for handling flows of network data.
     * @param options A dictionary containing keys and values passed by the provider's containing app. If the containing app did not start the proxy then this parameter will be nil.
     * @param completionHandler A block that must be called when the process of starting the proxy is complete. If the proxy cannot be started then the subclass' implementation of this method must pass a non-nil NSError object to this block. A value of nil passed to the completion handler indicates that the proxy was successfully started.
     */
    @available(macOS 10.11, *)
    open func startProxy(options: [String : Any]? = nil, completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method startProxyWithOptions:completionHandler:
     * @discussion This function is called by the framework when a new proxy instance is being created. Subclasses must override this method to perform whatever steps are necessary to ready the proxy for handling flows of network data.
     * @param options A dictionary containing keys and values passed by the provider's containing app. If the containing app did not start the proxy then this parameter will be nil.
     * @param completionHandler A block that must be called when the process of starting the proxy is complete. If the proxy cannot be started then the subclass' implementation of this method must pass a non-nil NSError object to this block. A value of nil passed to the completion handler indicates that the proxy was successfully started.
     */
    @available(macOS 10.11, *)
    open func startProxy(options: [String : Any]? = nil) async throws

    /**
     * @method stopProxyWithReason:completionHandler:
     * @discussion This function is called by the framework when the proxy is being stopped. Subclasses must override this method to perform whatever steps are necessary to stop the proxy.
     * @param reason An NEProviderStopReason indicating why the proxy is being stopped.
     * @param completionHandler A block that must be called when the proxy is completely stopped.
     */
    @available(macOS 10.11, *)
    open func stopProxy(with reason: NEProviderStopReason, completionHandler: @escaping @Sendable () -> Void)

    /**
     * @method stopProxyWithReason:completionHandler:
     * @discussion This function is called by the framework when the proxy is being stopped. Subclasses must override this method to perform whatever steps are necessary to stop the proxy.
     * @param reason An NEProviderStopReason indicating why the proxy is being stopped.
     * @param completionHandler A block that must be called when the proxy is completely stopped.
     */
    @available(macOS 10.11, *)
    open func stopProxy(with reason: NEProviderStopReason) async

    /**
     * @method cancelProxyWithError:
     * @discussion This function is called by proxy provider implementations to stop the proxy when a network error is encountered that renders the proxy no longer viable. Subclasses should not override this method.
     * @param error An NSError object containing details about the error that the proxy provider implementation encountered.
     */
    @available(macOS 10.11, *)
    open func cancelProxyWithError(_ error: (any Error)?)

    /**
     * @method handleNewFlow:
     * @discussion This function is called by the framework to deliver a new network data flow to the proxy provider implementation. Subclasses must override this method to perform whatever steps are necessary to ready the proxy to receive data from the flow. The proxy provider implementation indicates that the proxy is ready to handle flow data by calling -[NEAppProxyFlow openWithLocalFlowEndpoint:completionHandler:] on the flow. If the proxy implementation decides to not handle the flow and instead terminate it, the subclass implementation of this method should return NO. If the proxy implementation decides to handle the flow, the subclass implementation of this method should return YES. In this case the proxy implementation is responsible for retaining the NEAppProxyFlow object.
     * @param flow The new flow
     * @return YES if the proxy implementation has retained the flow and intends to handle the flow data. NO if the proxy implementation has not retained the flow and will not handle the flow data. In NETransparentProxyProvider sub-classes returning NO causes the flow to be handled by the networking stack without any proxy. In all other cases the flow is terminated when NO is returned.
     */
    @available(macOS 10.11, *)
    open func handleNewFlow(_ flow: NEAppProxyFlow) -> Bool

    /**
     * @method handleNewUDPFlow:initialRemoteEndpoint:
     * @discussion This function is called by the framework to deliver a new UDP data flow to the proxy provider implementation. Subclasses can override this method to perform whatever steps are necessary to ready the proxy to receive
     *     data from the flow. The proxy provider implementation indicates that the proxy is ready to handle flow data by calling -[NEAppProxyFlow openWithLocalEndpoint:completionHandler:] on the flow. If the proxy implementation decides
     *     to not handle the flow and instead terminate it, the subclass implementation of this method should return NO. If the proxy implementation decides to handle the flow, the subclass implementation of this method should return YES.
     *     In this case the proxy implementation is responsible for retaining the NEAppProxyUDPFlow object.
     *     The default implementation of this method calls -[NEAppProxyProvider handleNewFlow:] and returns its result.
     * @param flow The new UDP flow
     * @param remoteEndpoint The initial remote endpoint provided by the proxied app when the flow was opened.
     * @return YES if the proxy implementation has retained the flow and intends to handle the flow data. NO if the proxy implementation has not retained the flow and will not handle the flow data. In NETransparentProxyProvider sub-classes returning NO causes the flow to be handled by the networking stack without any proxy. In all other cases the flow is terminated when NO is returned.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    open func handleNewUDPFlow(_ flow: NEAppProxyUDPFlow, initialRemoteEndpoint remoteEndpoint: NWEndpoint) -> Bool
}

@available(macOS 10.11, *)
public struct NEVPNError : CustomNSError, Hashable, Error {

    public init(_nsError: NSError)

    public static var errorDomain: String { get }

    /**
     * @typedef NEVPNError
     * @abstract VPN error codes
     */
    @available(macOS 10.11, *)
    public enum Code : Int, @unchecked Sendable, Equatable {

        /**
         * @typedef NEVPNError
         * @abstract VPN error codes
         */
        public typealias _ErrorType = NEVPNError

        /** @const NEVPNErrorConfigurationInvalid The VPN configuration is invalid */
        case configurationInvalid = 1

        /** @const NEVPNErrorConfigurationDisabled The VPN configuration is not enabled. */
        case configurationDisabled = 2

        /** @const NEVPNErrorConnectionFailed The connection to the VPN server failed. */
        case connectionFailed = 3

        /** @const NEVPNErrorConfigurationStale The VPN configuration is stale and needs to be loaded. */
        case configurationStale = 4

        /** @const NEVPNErrorConfigurationReadWriteFailed The VPN configuration cannot be read from or written to disk. */
        case configurationReadWriteFailed = 5

        /** @const NEVPNErrorConfigurationUnknown An unknown configuration error occurred. */
        case configurationUnknown = 6
    }

    /** @const NEVPNErrorConfigurationInvalid The VPN configuration is invalid */
    public static var configurationInvalid: NEVPNError.Code { get }

    /** @const NEVPNErrorConfigurationDisabled The VPN configuration is not enabled. */
    public static var configurationDisabled: NEVPNError.Code { get }

    /** @const NEVPNErrorConnectionFailed The connection to the VPN server failed. */
    public static var connectionFailed: NEVPNError.Code { get }

    /** @const NEVPNErrorConfigurationStale The VPN configuration is stale and needs to be loaded. */
    public static var configurationStale: NEVPNError.Code { get }

    /** @const NEVPNErrorConfigurationReadWriteFailed The VPN configuration cannot be read from or written to disk. */
    public static var configurationReadWriteFailed: NEVPNError.Code { get }

    /** @const NEVPNErrorConfigurationUnknown An unknown configuration error occurred. */
    public static var configurationUnknown: NEVPNError.Code { get }
}

/** @const NEVPNErrorDomain The VPN error domain */
@available(macOS 10.11, *)
public let NEVPNErrorDomain: String

extension NSNotification.Name {

    /** @const NEVPNConfigurationChangeNotification Name of the NSNotification that is posted when the VPN configuration changes. */
    @available(macOS 10.11, *)
    public static let NEVPNConfigurationChange: NSNotification.Name

    /** @const NEDNSProxyConfigurationDidChangeNotification Name of the NSNotification that is posted when the DNS proxy configuration changes. */
    @available(macOS 10.15, *)
    public static let NEDNSProxyConfigurationDidChange: NSNotification.Name

    /** @const NEDNSSettingsConfigurationDidChangeNotification Name of the NSNotification that is posted when the DNS settings configuration changes. */
    @available(macOS 11.0, *)
    public static let NEDNSSettingsConfigurationDidChange: NSNotification.Name

    /** @const NEFilterConfigurationDidChangeNotification Name of the NSNotification that is posted when the filter configuration changes. */
    @available(macOS 10.11, *)
    public static let NEFilterConfigurationDidChange: NSNotification.Name

    /** @const NERelayConfigurationDidChangeNotification Name of the NSNotification that is posted when the relay configuration changes. */
    @available(macOS 14.0, *)
    public static let NERelayConfigurationDidChange: NSNotification.Name

    /** @const NEVPNStatusDidChangeNotification Name of the NSNotification that is posted when the VPN status changes. */
    @available(macOS 10.11, *)
    public static let NEVPNStatusDidChange: NSNotification.Name
}

/**
 * @interface NEVPNManager
 * @discussion The NEVPNManager class declares the programmatic interface for an object that manages Virtual Private Network (VPN) configurations.
 *
 * NEVPNManager declares methods and properties for configuring and controlling a VPN.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEVPNManager : NSObject {

    /**
     * @method sharedManager
     * @return The singleton NEVPNManager object for the calling process.
     */
    @available(macOS 10.11, *)
    open class func shared() -> NEVPNManager

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current VPN configuration from the caller's VPN preferences.
     * @param completionHandler A block that will be called on the main thread when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func loadFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current VPN configuration from the caller's VPN preferences.
     * @param completionHandler A block that will be called on the main thread when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func loadFromPreferences() async throws

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the VPN configuration from the caller's VPN preferences. If the VPN is enabled, has VPN On Demand enabled, and has VPN On Demand rules, the VPN is disabled and the VPN On Demand rules are de-activated.
     * @param completionHandler A block that will be called on the main thread when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func removeFromPreferences(completionHandler: (@Sendable ((any Error)?) -> Void)? = nil)

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the VPN configuration from the caller's VPN preferences. If the VPN is enabled, has VPN On Demand enabled, and has VPN On Demand rules, the VPN is disabled and the VPN On Demand rules are de-activated.
     * @param completionHandler A block that will be called on the main thread when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func removeFromPreferences() async throws

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the VPN configuration in the caller's VPN preferences. If the VPN is enabled, has VPN On Demand enabled, and has VPN On Demand rules, the VPN On Demand rules are activated.
     *
     * @param completionHandler A block that will be called on the main thread when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func saveToPreferences(completionHandler: (@Sendable ((any Error)?) -> Void)? = nil)

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the VPN configuration in the caller's VPN preferences. If the VPN is enabled, has VPN On Demand enabled, and has VPN On Demand rules, the VPN On Demand rules are activated.
     *
     * @param completionHandler A block that will be called on the main thread when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func saveToPreferences() async throws

    /**
     * @method setAuthorization:
     * @discussion This function sets an authorization object that can be used to obtain the authorization rights necessary to modify the system VPN configuration.
     * @param authorization The AuthorizationRef to use to obtain rights.
     */
    @available(macOS 10.11, *)
    open func setAuthorization(_ authorization: AuthorizationRef)

    /**
     * @property onDemandRules
     * @discussion An array of NEOnDemandRule objects.
     */
    @available(macOS 10.11, *)
    open var onDemandRules: [NEOnDemandRule]?

    /**
     * @property onDemandEnabled
     * @discussion Toggles VPN On Demand.
     */
    @available(macOS 10.11, *)
    open var isOnDemandEnabled: Bool

    /**
     * @property localizedDescription
     * @discussion A string containing a description of the VPN.
     */
    @available(macOS 10.11, *)
    open var localizedDescription: String?

    /**
     * @property protocol
     * @discussion An NEVPNProtocol object containing the protocol-specific portion of the VPN configuration.
     */
    @available(macOS, introduced: 10.11, deprecated: 10.11)
    open var `protocol`: NEVPNProtocol?

    /**
     * @property protocolConfiguration
     * @discussion An NEVPNProtocol object containing the protocol-specific portion of the VPN configuration.
     */
    @available(macOS 10.11, *)
    open var protocolConfiguration: NEVPNProtocol?

    /**
     * @property connection
     * @discussion The NEVPNConnection object used for controlling the VPN tunnel.
     */
    @available(macOS 10.11, *)
    open var connection: NEVPNConnection { get }

    /**
     * @property enabled
     * @discussion Toggles the enabled status of the VPN. Setting this property will disable VPN configurations of other apps. This property will be set to NO  when other VPN configurations are enabled.
     */
    @available(macOS 10.11, *)
    open var isEnabled: Bool
}

/**
 * @interface NETunnelProviderManager
 * @discussion The NETunnelProviderManager class declares the programmatic interface for an object that is used to configure and control network tunnels provided by NETunnelProviders.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NETunnelProviderManager : NEVPNManager {

    /**
     * @method loadAllFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the NETunnelProvider configurations created by the calling app that have previously been saved to disk and returns them as NETunnelProviderManager objects.
     * @param completionHandler A block that takes an array NETunnelProviderManager objects. The array passed to the block may be empty if no NETunnelProvider configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open class func loadAllFromPreferences(completionHandler: @escaping @Sendable ([NETunnelProviderManager]?, (any Error)?) -> Void)

    /**
     * @method loadAllFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the NETunnelProvider configurations created by the calling app that have previously been saved to disk and returns them as NETunnelProviderManager objects.
     * @param completionHandler A block that takes an array NETunnelProviderManager objects. The array passed to the block may be empty if no NETunnelProvider configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open class func loadAllFromPreferences() async throws -> [NETunnelProviderManager]

    /**
     * @method forPerAppVPN
     * @discussion Create a NETunnelProviderManager instance that is used to manage a per-app VPN configuration.
     */
    @available(macOS 10.15.4, *)
    open class func forPerAppVPN() -> Self

    /**
     * @method copyAppRules
     * @discussion This function returns an array of NEAppRule objects.
     */
    @available(macOS 10.11, *)
    open func copyAppRules() -> [NEAppRule]?

    /**
     * @property routingMethod
     * @discussion The method by which network traffic is routed to the tunnel. The default is NETunnelProviderRoutingMethodDestinationIP.
     */
    @available(macOS 10.11, *)
    open var routingMethod: NETunnelProviderRoutingMethod { get }

    /**
     * @property safariDomains
     * @discussion An array of domain strings. Only applies to per-app VPN configurations. When the per-app VPN is enabled and the user navigates in Safari to a web site within one of these domains,
     *     the web site network traffic is routed through the per-app VPN.
     */
    @available(macOS 10.15.4, *)
    open var safariDomains: [String]

    /**
     * @property mailDomains
     * @discussion An array of domain strings. Only applies to per-app VPN configurations. When the per-app VPN is enabled, connections from the Mail app to mail servers within
     *     one of these domains are routed through the per-app VPN.
     */
    @available(macOS 10.15.4, *)
    open var mailDomains: [String]

    /**
     * @property calendarDomains
     * @discussion An array of domain strings. Only applies to per-app VPN configurations. When the per-app VPN is enabled, connections from the Calendar app to calendar servers within one of
     *     these domains are routed through the per-app VPN.
     */
    @available(macOS 10.15.4, *)
    open var calendarDomains: [String]

    /**
     * @property contactsDomains
     * @discussion An array of domain strings. Only applies to per-app VPN configurations. When the per-app VPN is enabled, connections from the Contacts app to contacts servers within one of these
     *     domains are routed through the per-app VPN.
     */
    @available(macOS 10.15.4, *)
    open var contactsDomains: [String]

    /**
     * @property appRules
     * @property An array of NEAppRule objects. Only applies to per-app VPN configurations. Network traffic originating from apps matching one of these rules is routed through the per-app VPN.
     */
    @available(macOS 10.15.4, *)
    open var appRules: [NEAppRule]

    /**
     * @property excludedDomains
     * @property An array of domain strings. Only applies to per-app VPN configurations. When the per-app VPN is enabled, connections to servers within one of these domains are excluded from the
     *   per-app VPN.
     */
    @available(macOS 11.0, *)
    open var excludedDomains: [String]

    /**
     * @property associatedDomains
     * @property An array of domain strings. Only applies to per-app VPN configurations. HTTP requests to download the Apple App Site Association files for domains in this list are routed through the per-app VPN.
     */
    @available(macOS 11.0, *)
    open var associatedDomains: [String]
}

/**
 * @interface NEAppProxyProviderManager
 * @discussion The NEAppProxyProviderManager class declares the programmatic interface for an object that is used to configure and control network tunnels provided by NEAppProxyProviders.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEAppProxyProviderManager : NETunnelProviderManager {

    /**
     * @method loadAllFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the NEAppProxy configurations associated with the calling app that have previously been saved to disk and returns them as NEAppProxyProviderManager objects.
     * @param completionHandler A block that takes an array NEAppProxyProviderManager objects. The array passed to the block may be empty if no NETunnelProvider configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open class func loadAllFromPreferences(completionHandler: @escaping @Sendable ([NEAppProxyProviderManager]?, (any Error)?) -> Void)

    /**
     * @method loadAllFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the NEAppProxy configurations associated with the calling app that have previously been saved to disk and returns them as NEAppProxyProviderManager objects.
     * @param completionHandler A block that takes an array NEAppProxyProviderManager objects. The array passed to the block may be empty if no NETunnelProvider configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open class func loadAllFromPreferences() async throws -> [NEAppProxyProviderManager]
}

/**
 * @interface NEAppProxyTCPFlow
 * @discussion The NEAppProxyTCPFlow class declares the programmatic interface of an object that is used by NEAppProxyProvider implementations to proxy the payload of TCP connections.
 *
 * NEAppProxyTCPFlow is part of NetworkExtension.framework
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEAppProxyTCPFlow : NEAppProxyFlow {

    /**
     * @method readDataWithCompletionHandler:
     * @discussion Read data from the flow.
     * @param completionHandler A block that will be executed when some data is read from the flow. The block is passed either the data that was read or a non-nil error if an error occurred. If data has a length of 0 then no data can be subsequently read from the flow. The completion handler is only called for the single read operation that was initiated by calling this method. If the caller wants to read more data then it should call this method again to schedule another read operation and another execution of the completion handler block.
     */
    @available(macOS 10.11, *)
    open func readData(completionHandler: @escaping (Data?, (any Error)?) -> Void)

    /**
     * @method writeData:completionHandler
     * @discussion Write data to the flow.
     * @param data The data to write.
     * @param completionHandler A block that will be executed when the data is written into the associated socket's receive buffer. The caller should use this callback as an indication that it is possible to write more data to the flow without using up excessive buffer memory. If an error occurs while writing the data then a non-nil NSError object is passed to the block.
     */
    @available(macOS 10.11, *)
    open func write(_ data: Data, withCompletionHandler completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method writeData:completionHandler
     * @discussion Write data to the flow.
     * @param data The data to write.
     * @param completionHandler A block that will be executed when the data is written into the associated socket's receive buffer. The caller should use this callback as an indication that it is possible to write more data to the flow without using up excessive buffer memory. If an error occurs while writing the data then a non-nil NSError object is passed to the block.
     */
    @available(macOS 10.11, *)
    open func write(_ data: Data) async throws

    /**
     * @property remoteEndpoint
     * @discussion An NWEndpoint object containing information about the intended remote endpoint of the flow.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open var remoteEndpoint: NWEndpoint { get }
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEAppProxyTCPFlow {

    /// An NWEndpoint containing information about the intended remote endpoint of the flow.
    public var remoteFlowEndpoint: NWEndpoint { get }
}

/**
 * @interface NEAppProxyUDPFlow
 * @discussion The NEAppProxyUDPFlow class declares the programmatic interface of an object that is used by NEAppProxyProvider implementations to proxy the payload of UDP datagrams.
 *
 * NEAppProxyUDPFlow is part of NetworkExtension.framework.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEAppProxyUDPFlow : NEAppProxyFlow {

    /**
     * @method readDatagramsWithCompletionHandler:
     * @discussion Read datagrams from the flow.
     * @param completionHandler A block that will be executed when datagrams have been read from the flow. The block takes the datagrams that were read, the destination endpoints of the datagrams, and an NSError. If an error occurred while reading then the error parameter will be non-nil.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open func readDatagrams(completionHandler: @escaping ([Data]?, [NWEndpoint]?, (any Error)?) -> Void)

    /**
     * @method writeDatagrams:sentByEndpoint:completionHandler:
     * @discussion Write datagrams to the flow.
     * @param datagrams An array of NSData objects containing the data to be written.
     * @param remoteEndpoints The source endpoints of the datagrams.
     * @param completionHandler A block that will be executed when the datagrams have been written to the corresponding socket's receive buffer.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open func writeDatagrams(_ datagrams: [Data], sentBy remoteEndpoints: [NWEndpoint], completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method writeDatagrams:sentByEndpoint:completionHandler:
     * @discussion Write datagrams to the flow.
     * @param datagrams An array of NSData objects containing the data to be written.
     * @param remoteEndpoints The source endpoints of the datagrams.
     * @param completionHandler A block that will be executed when the datagrams have been written to the corresponding socket's receive buffer.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open func writeDatagrams(_ datagrams: [Data], sentBy remoteEndpoints: [NWEndpoint]) async throws

    /**
     * @property localEndpoint
     * @discussion An NWEndpoint object containing the local endpoint of the flow's corresponding socket.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0)
    open var localEndpoint: NWEndpoint? { get }
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEAppProxyUDPFlow {

    /// Read datagrams from the flow.
    /// - Parameter completionHandler: A closure that will be executed when datagrams have been read from the flow. The closure takes the datagrams that were read, the destination endpoints of the datagrams, and an Error. If an error occurred while reading then the error parameter will be non-nil.
    public func readDatagrams(completionHandler: @escaping ([(Data, NWEndpoint)]?, (any Error)?) -> Void)

    /// Read datagrams from the flow.
    /// - Returns: Datagrams that were read, the destination endpoints of the datagrams, and an Error. If an error occurred while reading then the error element will be non-nil.
    public func readDatagrams() async -> ([(Data, NWEndpoint)]?, (any Error)?)

    /// Write datagrams to the flow.
    /// - Parameters:
    ///   - array: Datagrams to be written, and the source endpoints of the datagrams.
    ///   - completionHandler: A closure that will be executed when the datagrams have been written to the corresponding socket's receive buffer.
    public func writeDatagrams(_ array: [(Data, NWEndpoint)], completionHandler: @escaping ((any Error)?) -> Void)

    /// Write datagrams to the flow.
    /// - Parameter array: Datagrams to be written, and the source endpoints of the datagrams.
    public func writeDatagrams(_ array: [(Data, NWEndpoint)]) async throws

    /// An NWEndpoint containing the local endpoint of the flow's corresponding socket.
    public var localFlowEndpoint: NWEndpoint? { get }
}

/**
 * @interface NEAppRule
 * @discussion The NEAppRule class declares the programmatic interface for an object that contains the match conditions for a rule that is used to match network traffic originated by applications.
 *
 * NEAppRule is used in the context of a Network Extension configuration to specify what traffic should be made available to the Network Extension.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEAppRule : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithSigningIdentifier:designatedRequirement:
     * @discussion Initializes a newly-allocated NEAppRule object.
     * @param signingIdentifier The signing identifier of the executable that matches the rule.
     * @param designatedRequirement The designated requirement of the executable that matches the rule.
     */
    @available(macOS 10.11, *)
    public init(signingIdentifier: String, designatedRequirement: String)

    /**
     * @property matchSigningIdentifier
     * @discussion A string containing a signing identifier. If the code signature of the executable being evaluated has a signing identifier equal to this string and all other conditions of the rule match, then the rule matches.
     */
    @available(macOS 10.11, *)
    open var matchSigningIdentifier: String { get }

    /**
     * @property matchDesignatedRequirement
     * @discussion A string containing a designated requirement. If the code signature of the exectuable being evaluated has a designated requirement equal to this string and all other conditions of the rule match, then the rule matches. This property is required on Mac OS X.
     */
    @available(macOS 10.11, *)
    open var matchDesignatedRequirement: String { get }

    /**
     * @property matchPath
     * @discussion A string containing a file system path. If the file system path of the executable being evaluated is equal to this string and all other conditions of the rule match, then the rule matches. This property is optional.
     */
    @available(macOS 10.11, *)
    open var matchPath: String?

    /**
     * @property matchDomains
     * @discussion An array of strings. This property is actually read-only. If the destination host of the network traffic being evaluated has a suffix equal to one of the strings in this array and all other conditions of the rule match, then the rule matches. This property is optional.
     */
    @available(macOS 10.11, *)
    open var matchDomains: [Any]?

    /**
     * @property matchTools
     * @discussion An array of NEAppRule objects. Use this property to restrict this rule to only match network traffic that is generated by one or more "helper tool" processes that are spawned by the app that matches this rule.
     *     For example, to match network traffic generated by the "curl" command line tool when the tool is run from Terminal.app, create an NEAppRule for Terminal.app and set the app rule's matchTools property to an array that
     *     contains an NEAppRule for the "curl" command line tool.
     *     Set this property to nil (which is the default) to match all network traffic generated by the matching app and all helper tool processes spawned by the matching app.
     */
    @available(macOS 10.15.4, *)
    open var matchTools: [NEAppRule]?
}

/**
 * @typedef NEDNSProxyError
 * @abstract DNS proxy error codes
 */
@available(macOS 10.15, *)
public enum NEDNSProxyManagerError : Int, @unchecked Sendable {

    /** @const NEDNSProxyManagerErrorConfigurationInvalid The DNS proxy configuration is invalid */
    case configurationInvalid = 1

    /** @const NEDNSProxyManagerErrorConfigurationDisabled The DNS proxy configuration is not enabled. */
    case configurationDisabled = 2

    /** @const NEDNSProxyManagerErrorConfigurationStale The DNS proxy configuration needs to be loaded. */
    case configurationStale = 3

    /** @const NEDNSProxyManagerErrorConfigurationCannotBeRemoved The DNS proxy configuration cannot be removed. */
    case configurationCannotBeRemoved = 4
}

/** @const NEDNSProxyManagerErrorDomain The DNS proxy error domain */
@available(macOS 10.15, *)
public let NEDNSProxyErrorDomain: String

/**
 * @interface NEDNSProxyManager
 * @discussion The NEDNSProxyManager class declares the programmatic interface for an object that manages DNS proxy configurations.
 *
 * NEDNSProxyManager declares methods and properties for configuring and controlling a DNS proxy.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.15, *)
open class NEDNSProxyManager : NSObject {

    /**
     * @method sharedManager
     * @return The singleton NEDNSProxyManager object for the calling process.
     */
    @available(macOS 10.15, *)
    open class func shared() -> NEDNSProxyManager

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current DNS proxy configuration from the caller's DNS proxy preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open func loadFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current DNS proxy configuration from the caller's DNS proxy preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open func loadFromPreferences() async throws

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the DNS proxy configuration from the caller's DNS proxy preferences. If the DNS proxy is enabled, the DNS proxy becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open func removeFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the DNS proxy configuration from the caller's DNS proxy preferences. If the DNS proxy is enabled, the DNS proxy becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open func removeFromPreferences() async throws

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the DNS proxy configuration in the caller's DNS proxy preferences. If the DNS proxy is enabled, it will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open func saveToPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the DNS proxy configuration in the caller's DNS proxy preferences. If the DNS proxy is enabled, it will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open func saveToPreferences() async throws

    /**
     * @property localizedDescription
     * @discussion A string containing a description of the DNS proxy.
     */
    @available(macOS 10.15, *)
    open var localizedDescription: String?

    /**
     * @property providerProtocol
     * @discussion An NEDNSProxyProviderProtocol object containing the provider-specific portion of the DNS proxy configuration.
     */
    @available(macOS 10.15, *)
    open var providerProtocol: NEDNSProxyProviderProtocol?

    /**
     * @property enabled
     * @discussion Toggles the enabled status of the DNS proxy. Setting this property will disable DNS proxy configurations of other apps. This property will be set to NO when other DNS proxy configurations are enabled.
     */
    @available(macOS 10.15, *)
    open var isEnabled: Bool
}

/**
 * @interface NEDNSProxyProvider
 * @discussion The NEDNSProxyProvider class declares the programmatic interface for an object that implements the client side of a custom DNS proxy solution.
 *
 * NEDNSProxyProvider is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEDNSProxyProvider : NEProvider {

    /**
     * @method startProxyWithOptions:completionHandler:
     * @discussion This function is called by the framework when a new proxy instance is being created. Subclasses must override this method to perform whatever steps are necessary to ready the proxy for handling flows of network data.
     * @param options A dictionary containing keys and values passed by the provider's containing app. If the containing app did not start the proxy then this parameter will be nil.
     * @param completionHandler A block that must be called when the process of starting the proxy is complete. If the proxy cannot be started then the subclass' implementation of this method must pass a non-nil NSError object to this block. A value of nil passed to the completion handler indicates that the proxy was successfully started.
     */
    @available(macOS 10.15, *)
    open func startProxy(options: [String : Any]? = nil, completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method startProxyWithOptions:completionHandler:
     * @discussion This function is called by the framework when a new proxy instance is being created. Subclasses must override this method to perform whatever steps are necessary to ready the proxy for handling flows of network data.
     * @param options A dictionary containing keys and values passed by the provider's containing app. If the containing app did not start the proxy then this parameter will be nil.
     * @param completionHandler A block that must be called when the process of starting the proxy is complete. If the proxy cannot be started then the subclass' implementation of this method must pass a non-nil NSError object to this block. A value of nil passed to the completion handler indicates that the proxy was successfully started.
     */
    @available(macOS 10.15, *)
    open func startProxy(options: [String : Any]? = nil) async throws

    /**
     * @method stopProxyWithReason:completionHandler:
     * @discussion This function is called by the framework when the proxy is being stopped. Subclasses must override this method to perform whatever steps are necessary to stop the proxy.
     * @param reason An NEProviderStopReason indicating why the proxy is being stopped.
     * @param completionHandler A block that must be called when the proxy is completely stopped.
     */
    @available(macOS 10.15, *)
    open func stopProxy(with reason: NEProviderStopReason, completionHandler: @escaping @Sendable () -> Void)

    /**
     * @method stopProxyWithReason:completionHandler:
     * @discussion This function is called by the framework when the proxy is being stopped. Subclasses must override this method to perform whatever steps are necessary to stop the proxy.
     * @param reason An NEProviderStopReason indicating why the proxy is being stopped.
     * @param completionHandler A block that must be called when the proxy is completely stopped.
     */
    @available(macOS 10.15, *)
    open func stopProxy(with reason: NEProviderStopReason) async

    /**
     * @method cancelProxyWithError:
     * @discussion This function is called by proxy provider implementations to stop the proxy when a network error is encountered that renders the proxy no longer viable. Subclasses should not override this method.
     * @param error An NSError object containing details about the error that the proxy provider implementation encountered.
     */
    @available(macOS 10.15, *)
    open func cancelProxyWithError(_ error: (any Error)?)

    /**
     * @method handleNewFlow:
     * @discussion This function is called by the framework to deliver a new network data flow to the proxy provider implementation. Subclasses must override this method to perform whatever steps are necessary to ready the proxy to receive data from the flow. The proxy provider implementation indicates that the proxy is ready to handle flow data by calling -[NEAppProxyFlow openWithLocalFlowEndpoint:completionHandler:] on the flow. If the proxy implementation decides to not handle the flow and instead terminate it, the subclass implementation of this method should return NO. If the proxy implementation decides to handle the flow, the subclass implementation of this method should return YES. In this case the proxy implementation is responsible for retaining the NEAppProxyFlow object.
     * @param flow The new flow
     * @return YES if the proxy implementation has retained the flow and intends to handle the flow data. NO if the proxy implementation has not retained the flow and will not handle the flow data. In this case the flow is terminated.
     */
    @available(macOS 10.15, *)
    open func handleNewFlow(_ flow: NEAppProxyFlow) -> Bool

    /**
     * @method handleNewUDPFlow:initialRemoteEndpoint:
     * @discussion This function is called by the framework to deliver a new UDP data flow to the proxy provider implementation. Subclasses can override this method to perform whatever steps are necessary to ready the proxy to receive
     *     data from the flow. The proxy provider implementation indicates that the proxy is ready to handle flow data by calling -[NEAppProxyFlow openWithLocalEndpoint:completionHandler:] on the flow. If the proxy implementation decides
     *     to not handle the flow and instead terminate it, the subclass implementation of this method should return NO. If the proxy implementation decides to handle the flow, the subclass implementation of this method should return YES.
     *     In this case the proxy implementation is responsible for retaining the NEAppProxyUDPFlow object.
     *     The default implementation of this method calls -[NEAppProxyProvider handleNewFlow:] and returns its result.
     * @param flow The new UDP flow
     * @param remoteEndpoint The initial remote endpoint provided by the proxied app when the flow was opened.
     * @return YES if the proxy implementation has retained the flow and intends to handle the flow data. NO if the proxy implementation has not retained the flow and will not handle the flow data. In this case the flow is terminated.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    open func handleNewUDPFlow(_ flow: NEAppProxyUDPFlow, initialRemoteEndpoint remoteEndpoint: NWEndpoint) -> Bool

    /**
     * @property systemDNSSettings
     * @discussion The current system DNS settings. Use KVO to watch for changes.
     */
    @available(macOS 10.15, *)
    open var systemDNSSettings: [NEDNSSettings]? { get }
}

/**
 * @interface NEProxyServer
 * @discussion The NEProxyServer class declares the programmatic interface for an object that contains settings for a proxy server.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEProxyServer : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithAddress:port:
     * @discussion This function initializes a newly-allocated NEProxyServer object
     * @param address The string representation of the proxy server IP address.
     * @param port The TCP port of the proxy server.
     */
    @available(macOS 10.11, *)
    public init(address: String, port: Int)

    /**
     * @property address
     * @discussion The string representation of the proxy server IP address.
     */
    @available(macOS 10.11, *)
    open var address: String { get }

    /**
     * @property port
     * @discussion The TCP port of the proxy server.
     */
    @available(macOS 10.11, *)
    open var port: Int { get }

    /**
     * @property authenticationRequired
     * @discussion A flag indicating if the server requires authentication credentials.
     */
    @available(macOS 10.11, *)
    open var authenticationRequired: Bool

    /**
     * @property username
     * @discussion The username portion of the authentication credential to use when communicating with the proxy server.
     */
    @available(macOS 10.11, *)
    open var username: String?

    /**
     * @property password
     * @discussion The password portion of the authentication credential to use when communicating with the proxy server. This property is only saved persistently if the username property is non-nil and non-empty and if the authenticationRequired flag is set.
     */
    @available(macOS 10.11, *)
    open var password: String?
}

/**
 * @interface NEProxySettings
 * @discussion The NEProxySettings class declares the programmatic interface for an object that contains proxy settings.
 *
 * NEProxySettings is used in the context of a Network Extension configuration to specify the proxy that should be used for network traffic when the Network Extension is active.
 */
@available(macOS 10.11, *)
open class NEProxySettings : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property autoProxyConfigurationEnabled
     * @discussion A boolean indicating if proxy auto-configuration is enabled.
     */
    @available(macOS 10.11, *)
    open var autoProxyConfigurationEnabled: Bool

    /**
     * @property proxyAutoConfigurationURL
     * @discussion A URL specifying where the PAC script is located.
     */
    @available(macOS 10.11, *)
    open var proxyAutoConfigurationURL: URL?

    /**
     * @property proxyAutoConfigurationJavaScript
     * @discussion A string containing the PAC JavaScript source code.
     */
    @available(macOS 10.11, *)
    open var proxyAutoConfigurationJavaScript: String?

    /**
     * @property HTTPEnabled
     * @discussion A boolean indicating if the static HTTP proxy is enabled.
     */
    @available(macOS 10.11, *)
    open var httpEnabled: Bool

    /**
     * @property HTTPServer
     * @discussion A NEProxyServer object containing the HTTP proxy server settings.
     */
    @available(macOS 10.11, *)
    @NSCopying open var httpServer: NEProxyServer?

    /**
     * @property HTTPSEnabled
     * @discussion A boolean indicating if the static HTTPS proxy is enabled.
     */
    @available(macOS 10.11, *)
    open var httpsEnabled: Bool

    /**
     * @property HTTPSServer
     * @discussion A NEProxyServer object containing the HTTPS proxy server settings.
     */
    @available(macOS 10.11, *)
    @NSCopying open var httpsServer: NEProxyServer?

    /**
     * @property excludeSimpleHostnames
     * @discussion A flag indicating if the proxy settings should not be used for network destinations specified using single-label host names.
     */
    @available(macOS 10.11, *)
    open var excludeSimpleHostnames: Bool

    /**
     * @property exceptionList
     * @discussion An array of domain strings. If the destination host name of a connection shares a suffix with one of these strings then the proxy settings will not be used for the connection.
     */
    @available(macOS 10.11, *)
    open var exceptionList: [String]?

    /**
     * @property matchDomains
     * @discussion An array of domain strings. If the destination host name of a connection shares a suffix with one of these strings then the proxy settings will be used for the connection. Otherwise the proxy settings will not be used. If this property is nil then all connections to which the Network Extension applies will use the proxy settings.
     */
    @available(macOS 10.11, *)
    open var matchDomains: [String]?
}

/**
 * @interface NEVPNProtocol
 * @discussion The NEVPNProtocol class declares the programmatic interface of an object that manages the protocol-specific portion of a VPN configuration.
 *
 * NEVPNProtocol is an abstract base class from which other protocol-specific classes are derived.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEVPNProtocol : NSObject, NSCopying, NSSecureCoding {

    /**
     * @property serverAddress
     * @discussion The VPN server. Depending on the protocol, may be an IP address, host name, or URL.
     */
    @available(macOS 10.11, *)
    open var serverAddress: String?

    /**
     * @property username
     * @discussion The username component of the VPN authentication credential.
     */
    @available(macOS 10.11, *)
    open var username: String?

    /**
     * @property passwordReference
     * @discussion The password component of the VPN authentication credential. The value is a persistent reference to a keychain item with the kSecClassGenericPassword class.
     */
    @available(macOS 10.11, *)
    open var passwordReference: Data?

    /**
     * @property identityReference
     * @discussion The certificate and private key component of the VPN authentication credential. The value is a persistent reference to a keychain item with the kSecClassIdentity class.
     */
    @available(macOS 10.11, *)
    open var identityReference: Data?

    /**
     * @property identityData
     * @discussion The PKCS12 data for the VPN authentication identity. The value is a NSData in PKCS12 format.
     */
    @available(macOS 10.11, *)
    open var identityData: Data?

    /**
     * @property identityDataPassword
     * @discussion The password to be used to decrypt the PKCS12 identity data.
     */
    @available(macOS 10.11, *)
    open var identityDataPassword: String?

    /**
     * @property disconnectOnSleep
     * @discussion If YES, the VPN connection will be disconnected when the device goes to sleep. The default is NO.
     */
    @available(macOS 10.11, *)
    open var disconnectOnSleep: Bool

    /**
     * @property proxySettings
     * @discussion An NEProxySettings object containing the proxy settings to use for connections routed through the tunnel.
     */
    @available(macOS 10.11, *)
    @NSCopying open var proxySettings: NEProxySettings?

    /**
     * @property includeAllNetworks
     * @discussion If this property is set to YES then all network traffic is routed through the tunnel, with some exclusions. Several of the exclusions
     * can be controlled with the excludeLocalNetworks, excludeCellularServices, excludeAPNs and excludeDeviceCommunication properties. See the documentation for those properties.
     * The following traffic is always excluded from the tunnel:
     * - Traffic necessary for connecting and maintaining the device's network connection, such as DHCP.
     * - Traffic necessary for connecting to captive networks.
     * - Certain cellular services traffic that is not routable over the internet and is instead directly routed to the cellular network. See the
     *   excludeCellularServices property for more details.
     * - Network communication with a companion device such as a watchOS device.
     * The default value of this property is NO.
     */
    @available(macOS 10.15, *)
    open var includeAllNetworks: Bool

    /**
     * @property excludeLocalNetworks
     * @discussion If YES, all traffic destined for local networks will be excluded from the tunnel. The default is NO on macOS and YES on iOS.
     */
    @available(macOS 10.15, *)
    open var excludeLocalNetworks: Bool

    /**
     * @property excludeCellularServices
     * @discussion If includeAllNetworks is set to YES and this property is set to YES, then internet-routable network traffic for cellular services
     * (VoLTE, Wi-Fi Calling, IMS, MMS, Visual Voicemail, etc.) is excluded from the tunnel. Note that some cellular carriers route cellular services traffic
     * directly to the carrier network, bypassing the internet. Such cellular services traffic is always excluded from the tunnel. The default value of this
     * property is YES.
     */
    @available(macOS 13.3, *)
    open var excludeCellularServices: Bool

    /**
     * @property excludeAPNs
     * @discussion If includeAllNetworks is set to YES and this property is set to YES, then network traffic for the Apple Push Notification service (APNs)
     * is excluded from the tunnel. The default value of this property is YES.
     */
    @available(macOS 13.3, *)
    open var excludeAPNs: Bool

    /**
     * @property excludeDeviceCommunication
     * @discussion If includeAllNetworks is set to YES and this property is set to YES, then network traffic used for communicating with devices connected via USB or Wi-Fi is excluded
     * from the tunnel. For example, Xcode uses a network tunnel to communicate with connected development devices like iPhone, iPad and TV. The default value of this
     * property is YES.
     */
    @available(macOS 14.4, *)
    open var excludeDeviceCommunication: Bool

    /**
     * @property enforceRoutes
     * @discussion If YES, route rules for this tunnel will take precendence over any locally-defined routes. The default is NO.
     */
    @available(macOS 11.0, *)
    open var enforceRoutes: Bool
}

/**
 * @interface NEDNSProxyProviderProtocol
 * @discussion The NEDNSProxyProviderProtocol class declares the programmatic interface for an object that contains NEDNSProxyProvider-specific configuration settings.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.13, *)
open class NEDNSProxyProviderProtocol : NEVPNProtocol {

    /**
     * @property providerConfiguration
     * @discussion A dictionary containing NEDNSProxyProvider vendor-specific configuration parameters. This dictionary is passed as-is to NEDNSProxyProviders when a DNS proxy is started.
     */
    @available(macOS 10.13, *)
    open var providerConfiguration: [String : Any]?

    /**
     * @property providerBundleIdentifier
     * @discussion A string containing the bundle identifier of the NEDNSProxyProvider to be used by this configuration.
     */
    @available(macOS 10.13, *)
    open var providerBundleIdentifier: String?
}

/**
 * @typedef NEDNSProtocol
 * @abstract DNS protocol variants
 */
@available(macOS 11.0, *)
public enum NEDNSProtocol : Int, @unchecked Sendable {

    /** @const NEDNSProtocolCleartext Use traditional cleartext DNS over UDP and TCP port 53 */
    case cleartext = 1

    /** @const NEDNSProtocolTLS Use DNS-over-TLS */
    case TLS = 2

    /** @const NEDNSProtocolHTTPS Use DNS-over-HTTPS */
    case HTTPS = 3
}

/**
 * @interface NEDNSSettings
 * @discussion The NEDNSSettings class declares the programmatic interface for an object that contains DNS settings.
 */
@available(macOS 10.11, *)
open class NEDNSSettings : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property dnsProtocol
     * @discussion The DNS protocol used by the settings.
     */
    @available(macOS 11.0, *)
    open var dnsProtocol: NEDNSProtocol { get }

    /**
     * @method initWithServers:
     * @discussion Initialize a newly-allocated NEDNSSettings object.
     * @param servers An array of DNS server IP address strings.
     */
    @available(macOS 10.11, *)
    public init(servers: [String])

    /**
     * @property servers
     * @discussion An array of DNS server address strings.
     */
    @available(macOS 10.11, *)
    open var servers: [String] { get }

    /**
     * @property searchDomains
     * @discussion An array of DNS server search domain strings.
     */
    @available(macOS 10.11, *)
    open var searchDomains: [String]?

    /**
     * @property domainName
     * @discussion A string containing the DNS domain.
     */
    @available(macOS 10.11, *)
    open var domainName: String?

    /**
     * @property matchDomains
     * @discussion An array of strings containing domain strings. If this property is non-nil, the DNS settings will only be used to resolve host names within the specified domains.
     */
    @available(macOS 10.11, *)
    open var matchDomains: [String]?

    /**
     * @property matchDomainsNoSearch
     * @discussion A boolean indicating if the match domains should be appended to the search domain list.  Default is NO (match domains will be appended to the search domain list).
     */
    @available(macOS 10.11, *)
    open var matchDomainsNoSearch: Bool

    /**
     * @property allowFailover
     * @discussion A boolean indicating if failover to the default system resolver is permitted on resolution failure.
     */
    @available(macOS 26.0, *)
    open var allowFailover: Bool
}

@available(macOS 11.0, *)
open class NEDNSOverTLSSettings : NEDNSSettings {

    /**
     * @property serverName
     * @discussion The name of the server to use for TLS certificate validation.
     */
    @available(macOS 11.0, *)
    open var serverName: String?

    /**
     * @property identityReference
     * @discussion The optional certificate identity keychain reference to use as a TLS client certificate.
     */
    @available(macOS 13.0, *)
    open var identityReference: Data?
}

@available(macOS 11.0, *)
open class NEDNSOverHTTPSSettings : NEDNSSettings {

    /**
     * @property serverURL
     * @discussion The URL to which to make DNS-over-HTTPS requests. The format should be an HTTPS URL with the path indicating the location of the DNS-over-HTTPS server, such as: "https://dnsserver.example.net/dns-query".
     */
    @available(macOS 11.0, *)
    open var serverURL: URL?

    /**
     * @property identityReference
     * @discussion The optional certificate identity keychain reference to use as a TLS client certificate.
     */
    @available(macOS 13.0, *)
    open var identityReference: Data?
}

/**
 * @typedef NEDNSSettingsManagerError
 * @abstract DNS Settings Manager error codes
 */
@available(macOS 11.0, *)
public enum NEDNSSettingsManagerError : Int, @unchecked Sendable {

    /** @const NEDNSSettingsManagerErrorConfigurationInvalid The DNS settings manager is invalid */
    case configurationInvalid = 1

    /** @const NEDNSSettingsManagerErrorConfigurationDisabled The DNS settings manager is not enabled. */
    case configurationDisabled = 2

    /** @const NEDNSSettingsManagerErrorConfigurationStale The DNS settings manager needs to be loaded. */
    case configurationStale = 3

    /** @const NEDNSSettingsManagerErrorConfigurationCannotBeRemoved The DNS settings manager cannot be removed. */
    case configurationCannotBeRemoved = 4
}

/** @const NEDNSSettingsManagerErrorDomain The DNS settings error domain */
@available(macOS 11.0, *)
public let NEDNSSettingsErrorDomain: String

/**
 * @interface NEDNSSettingsManager
 * @discussion The NEDNSSettingsManager class declares the programmatic interface for an object that manages DNS settings configurations.
 *
 * NEDNSSettingsManager declares methods and properties for configuring and controlling DNS settings on the system.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 11.0, *)
open class NEDNSSettingsManager : NSObject {

    /**
     * @method sharedManager
     * @return The singleton NEDNSSettingsManager object for the calling process.
     */
    @available(macOS 11.0, *)
    open class func shared() -> NEDNSSettingsManager

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current DNS settings configuration from the caller's DNS settings preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 11.0, *)
    open func loadFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current DNS settings configuration from the caller's DNS settings preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 11.0, *)
    open func loadFromPreferences() async throws

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the DNS settings configuration from the caller's DNS settings preferences. If the DNS settings are enabled, the DNS settings becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 11.0, *)
    open func removeFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the DNS settings configuration from the caller's DNS settings preferences. If the DNS settings are enabled, the DNS settings becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 11.0, *)
    open func removeFromPreferences() async throws

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the DNS settingsconfiguration in the caller's DNS settings preferences. If the DNS settings are enabled, they will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 11.0, *)
    open func saveToPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the DNS settingsconfiguration in the caller's DNS settings preferences. If the DNS settings are enabled, they will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 11.0, *)
    open func saveToPreferences() async throws

    /**
     * @property localizedDescription
     * @discussion A string containing a description of the DNS settings.
     */
    @available(macOS 11.0, *)
    open var localizedDescription: String?

    /**
     * @property dnsSettings
     * @discussion An NEDNSSettings object containing the DNS resolver configuration to apply to the system.
     */
    @available(macOS 11.0, *)
    open var dnsSettings: NEDNSSettings?

    /**
     * @property onDemandRules
     * @discussion An array of NEOnDemandRule objects. If nil, the associated DNS settings will always apply. If non-nil, the array describes the networks on which the DNS configuration should take effect or not.
     */
    @available(macOS 11.0, *)
    open var onDemandRules: [NEOnDemandRule]?

    /**
     * @property enabled
     * @discussion Checks the enabled status of the DNS settings. DNS settings must be enabled by the user in Settings or System Preferences.
     */
    @available(macOS 11.0, *)
    open var isEnabled: Bool { get }
}

extension NENetworkRule {

    /**
     * @typedef NENetworkRuleProtocol
     * @abstract IP protocols
     */
    @available(macOS 10.15, *)
    public enum `Protocol` : Int, @unchecked Sendable {

        /** @const NENetworkRuleProtocolAny Matches TCP and UDP traffic */
        case any = 0

        /** @const NENetworkRuleProtocolTCP Matches TCP traffic */
        case TCP = 1

        /** @const NENetworkRuleProtocolUDP Matches UDP traffic */
        case UDP = 2
    }
}

/**
 * @typedef NETrafficDirection
 * @abstract The direction of network traffic
 */
@available(macOS 10.15, *)
public enum NETrafficDirection : Int, @unchecked Sendable {

    /** @const NETrafficDirectionAny Any direction */
    case any = 0

    /** @const NETrafficDirectionInbound Inbound direction */
    case inbound = 1

    /** @const NETrafficDirectionOutbound Outbound direction */
    case outbound = 2
}

/**
 * @interface NENetworkRule
 * @discussion The NENetworkRule class declares the programmatic interface of an object that contains a specification of a rule that matches the attributes of network traffic.
 */
@available(macOS 10.15, *)
open class NENetworkRule : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithDestinationNetwork:prefix:protocol:
     * @discussion Initialize a newly-allocated NENetworkRule object that matches network traffic destined for a host within a specific network.
     * @param networkEndpoint An endpoint object that contains the port and address or network that the rule matches. This endpoint must contain an address, not a hostname.
     *        If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all destinations except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
     *        If the port string of the endpoint is "0" or is the empty string, then the rule will match traffic on any port destined for the given address or network.
     * @param destinationPrefix An integer that in combination with the address in the endpoint specifies the destination network that the rule matches.
     * @param protocol A NENetworkRuleProtocol value indicating the protocol that the rule matches.
     * @return The initialized NENetworkRule instance.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    public init(destinationNetwork networkEndpoint: NWHostEndpoint, prefix destinationPrefix: Int, protocol: NENetworkRule.`Protocol`)

    /**
     * @method initWithDestinationHost:protocol:
     * @discussion Initialize a newly-allocated NENetworkRule object that matches network traffic destined for a host within a specific DNS domain.
     * @param hostEndpoint An endpoint object that contains the port and hostname or domain that the rule matches. This endpoint must contain a hostname, not an address.
     *    If the port string of the NWHostEndpoint is "0" or is the empty string, then the rule will match traffic on any port destined for the given hostname or domain.
     *    If the hostname string of the endpoint consists of a single label, then the rule will match traffic destined to the specific host with that single label as its name.
     *    If the hostname string of the endpoint consists of 2 or more labels, then the rule will match traffic destined to hosts within the domain specified by the hostname string.
     *    Examples:
     *        [[NENetworkRule alloc] initWithDestinationHost:[NWHostEndpoint endpointWithHostname:@"com" port:@"0"] protocol:NENetworkRuleProtocolAny] - matches all TCP and UDP traffic to the host named "com".
     *        [[NENetworkRule alloc] initWithDestinationHost:[NWHostEndpoint endpointWithHostname:@"example.com" port:@"0"] protocol:NENetworkRuleProtocolAny] - matches all TCP and UDP traffic to hosts in the "example.com" DNS domain, including all DNS queries for names in the example.com DNS domain.
     *        [[NENetworkRule alloc] initWithDestinationHost:[NWHostEndpoint endpointWithHostname:@"example.com" port:@"53"] protocol:NENetworkRuleProtocolAny] - matches all DNS queries/responses for hosts in the "example.com" domain.
     *        [[NENetworkRule alloc] initWithDestinationHost:[NWHostEndpoint endpointWithHostname:@"example.com" port:@"443"] protocol:NENetworkRuleProtocolTCP] - matches all TCP port 443 traffic to hosts in the "example.com" domain.
     * @param protocol A NENetworkRuleProtocol value indicating the protocol that the rule matches.
     * @return The initialized NENetworkRule instance.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    public init(destinationHost hostEndpoint: NWHostEndpoint, protocol: NENetworkRule.`Protocol`)

    /**
     * @method initWithRemoteNetwork:remotePrefix:localNetwork:localPrefix:protocol:direction:
     * @discussion Initialize a newly-allocated NENetworkRule object that matches traffic by remote network, local network, protocol, and direction. If both remoteNetwork and localNetwork are nil
     *    then the rule will match all traffic of the given protocol and direction, except for loopback traffic. To match loopback traffic create a NENetworkRule with remoteNetwork and/or localNetwork properties that
     *    explicitly match traffic to the loopback address (127.0.0.1 or ::1).
     * @param remoteNetwork An endpoint object that contains the remote port and the remote address or network that the rule matches. This endpoint must contain an address, not a hostname.
     *    If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all destinations except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
     *    If the port string of the endpoint is "0" or is the empty string, then the rule will match traffic on any port coming from the remote network.
     *    Pass nil to cause the rule to match any remote network.
     * @param remotePrefix An integer that in combination with the address in remoteNetwork specifies the remote network that the rule matches.
     * @param localNetwork An endpoint object that contains the local port and the local address or network that the rule matches. This endpoint must contain an address, not a hostname.
     *    If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all local networks except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
     *    If the port string of the endpoint is "0" or is the empty string, then the rule will match traffic on any port coming from the local network.
     *    Pass nil to cause the rule to match any local network.
     * @param localPrefix An integer that in combination with the address in localNetwork specifies the local network that the rule matches. This parameter
     *    is ignored if localNetwork is nil.
     * @param protocol A NENetworkRuleProtocol value indicating the protocol that the rule matches.
     * @param direction A NETrafficDirection value indicating the direction of network traffic that the rule matches.
     * @return The initialized NENetworkRule instance.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    public init(remoteNetwork: NWHostEndpoint?, remotePrefix: Int, localNetwork: NWHostEndpoint?, localPrefix: Int, protocol: NENetworkRule.`Protocol`, direction: NETrafficDirection)

    /**
     * @property matchRemoteEndpoint
     * @discussion The remote endpoint that the rule matches.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    open var matchRemoteEndpoint: NWHostEndpoint? { get }

    /**
     * @property matchRemotePrefix
     * @discussion A number that specifies the remote sub-network that the rule matches. This property is set to NSNotFound for rules where matchRemoteEndpoint does not contain an IP address.
     */
    @available(macOS 10.15, *)
    open var matchRemotePrefix: Int { get }

    /**
     * @property matchLocalNetwork
     * @discussion The local network that the rule matches.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    open var matchLocalNetwork: NWHostEndpoint? { get }

    /**
     * @property matchLocalPrefix
     * @discussion A number that specifies the local sub-network that the rule matches. This property is set to NSNotFound for rules with a nil matchLocalNetwork property.
     */
    @available(macOS 10.15, *)
    open var matchLocalPrefix: Int { get }

    /**
     * @property matchProtocol
     * @discussion A NENetworkRuleProtocol value containing the protocol that the rule matches.
     */
    @available(macOS 10.15, *)
    open var matchProtocol: NENetworkRule.`Protocol` { get }

    /**
     * @property matchDirection
     * @discussion A NETrafficDirection value indicating the network traffic direction that the rule matches.
     */
    @available(macOS 10.15, *)
    open var matchDirection: NETrafficDirection { get }
}

@available(macOS 15.0, *)
@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension NENetworkRule {

    /// Create a NENetworkRule object that matches network traffic destined for a host within a specific network.
    /// - Parameters:
    ///   - networkEndpoint: An endpoint that contains the port and address or network that the rule matches. This endpoint must contain an address, not a hostname.
    ///     If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all destinations except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port destined for the given address or network.
    ///   - destinationPrefix: An integer that in combination with the address in the endpoint specifies the destination network that the rule matches.
    ///   - protocol: A NENetworkRule.Protocol value indicating the protocol that the rule matches.
    public convenience init(destinationNetworkEndpoint networkEndpoint: NWEndpoint, prefix destinationPrefix: Int, protocol: NENetworkRule.`Protocol`)

    /// Create a NENetworkRule object that matches network traffic destined for a host within a specific DNS domain.
    /// - Parameters:
    ///   - hostEndpoint: An endpoint that contains the port and hostname or domain that the rule matches. This endpoint must contain a hostname, not an address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port destined for the given hostname or domain.
    ///     If the hostname string of the endpoint consists of a single label, then the rule will match traffic destined to the specific host with that single label as its name.
    ///     If the hostname string of the endpoint consists of 2 or more labels, then the rule will match traffic destined to hosts within the domain specified by the hostname string.
    ///   - protocol: A NENetworkRule.Protocol value indicating the protocol that the rule matches.
    ///
    /// ```
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "com", port: 0), protocol: .any) // matches all TCP and UDP traffic to the host named "com".
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "example.com", port: 0), protocol: .any) // matches all TCP and UDP traffic to hosts in the "example.com" DNS domain, including all DNS queries for names in the example.com DNS domain.
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "example.com", port: 53), protocol: .any) // matches all DNS queries/responses for hosts in the "example.com" domain.
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "example.com", port: 443), protocol: .TCP) // matches all TCP port 443 traffic to hosts in the "example.com" domain.
    /// ```
    public convenience init(destinationHostEndpoint hostEndpoint: NWEndpoint, protocol: NENetworkRule.`Protocol`)

    /// Create a NENetworkRule object that matches traffic by remote network, local network, protocol, and direction.
    ///
    /// If both remoteNetworkEndpoint and localNetworkEndpoint are nil then the rule will match all traffic of the given protocol and direction, except for loopback traffic. To match loopback traffic create a NENetworkRule with remoteNetworkEndpoint and/or localNetworkEndpoint properties that explicitly match traffic to the loopback address (127.0.0.1 or ::1).
    /// - Parameters:
    ///   - remoteNetworkEndpoint: An endpoint that contains the remote port and the remote address or network that the rule matches. This endpoint must contain an address, not a hostname.
    ///     If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all destinations except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port coming from the remote network.
    ///     Pass nil to cause the rule to match any remote network.
    ///   - remotePrefix: An integer that in combination with the address in remoteNetworkEndpoint specifies the remote network that the rule matches.
    ///   - localNetworkEndpoint: An endpoint that contains the local port and the local address or network that the rule matches. This endpoint must contain an address, not a hostname.
    ///     If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all local networks except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port coming from the local network.
    ///     Pass nil to cause the rule to match any local network.
    ///   - localPrefix: An integer that in combination with the address in localNetworkEndpoint specifies the local network that the rule matches. This parameter is ignored if localNetworkEndpoint is nil.
    ///   - protocol: A NENetworkRule.Protocol value indicating the protocol that the rule matches.
    ///   - direction: A NETrafficDirection value indicating the direction of network traffic that the rule matches.
    public convenience init(remoteNetworkEndpoint: NWEndpoint?, remotePrefix: Int, localNetworkEndpoint: NWEndpoint?, localPrefix: Int, protocol: NENetworkRule.`Protocol`, direction: NETrafficDirection)

    /// The remote endpoint that the rule matches.
    public var matchRemoteHostOrNetworkEndpoint: NWEndpoint? { get }

    /// The local network that the rule matches.
    public var matchLocalNetworkEndpoint: NWEndpoint? { get }
}

public var NEFilterFlowBytesMax: UInt64 { get }

/**
 * @interface NEFilterFlow
 * @discussion The NEFilterFlow class declares the programmatic interface of an object that represents a flow of network data to be filtered.
 *
 * NEFilterFlow is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterFlow : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property URL
     * @discussion The flow's HTTP request URL. Will be nil if the flow did not originate from WebKit.
     */
    @available(macOS 10.15, *)
    open var url: URL? { get }

    /**
     *    @property direction
     *    @discussion Initial direction of the flow (outgoing or incoming flow)
     */
    @available(macOS 10.15, *)
    open var direction: NETrafficDirection { get }

    /**
     *    @property sourceAppAuditToken
     *    @discussion Audit token of the source application of the flow.
     */
    @available(macOS 10.15, *)
    open var sourceAppAuditToken: Data? { get }

    /**
     * @property sourceProcessAuditToken
     * @discussion The audit token of the process that created the flow. In cases where the connection was created by a system process on behalf of the source application,
     * sourceProcessAuditToken will be different from sourceAppAuditToken and will contain the audit token of the system process. In cases where the source application directly
     * created the connection sourceAppAuditToken and sourceProcessAuditToken will be identical.
     */
    @available(macOS 13.0, *)
    open var sourceProcessAuditToken: Data? { get }

    /**
     * @property identifier
     * @discussion The unique identifier of the flow.
     */
    @available(macOS 10.15, *)
    open var identifier: UUID { get }
}

/**
 * @interface NEFilterSocketFlow
 * @discussion The NEFilterSocketFlow class declares the programmatic interface of an object that represents a flow of network data to be filtered, which is originated from the socket.
 *
 * NEFilterSocketFlow is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterSocketFlow : NEFilterFlow, NSSecureCoding, NSCopying {

    /**
     * @property remoteEndpoint
     * @discussion The flow's remote endpoint. This endpoint object may be nil when [NEFilterDataProvider handleNewFlow:] is invoked and if so will be populated upon receiving network data.
            In such a case, filtering on the flow may still be performed based on its socket type, socket family or socket protocol.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    open var remoteEndpoint: NWEndpoint? { get }

    /**
     * @property remoteHostname
     * @discussion The flow's remote hostname. This property is only non-nil if the flow was created using Network.framework or NSURLSession.
     */
    @available(macOS 11.0, *)
    open var remoteHostname: String? { get }

    /**
     * @property localEndpoint
     * @discussion The flow's local endpoint. This endpoint object may be nil when [NEFilterDataProvider handleNewFlow:] is invoked and if so will be populated upon receiving network data.
            In such a case, filtering on the flow may still be performed based on its socket type, socket family or socket protocol.
     */
    @available(macOS, introduced: 10.15, deprecated: 15.0)
    open var localEndpoint: NWEndpoint? { get }

    /**
     *    @property socketFamily
     *    @discussion Socket family of the socket flow, such as PF_INET.
     */
    @available(macOS 10.15, *)
    open var socketFamily: Int32 { get }

    /**
     *    @property socketType
     *    @discussion Socket type of the socket flow, such as SOCK_STREAM.
     */
    @available(macOS 10.15, *)
    open var socketType: Int32 { get }

    /**
     *    @property socketProtocol
     *    @discussion Socket protocol of the socket flow, such as IPPROTO_TCP.
     */
    @available(macOS 10.15, *)
    open var socketProtocol: Int32 { get }
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEFilterSocketFlow {

    /// The flow's remote endpoint.
    ///
    /// This endpoint may be nil when `NEFilterDataProvider.handleNewFlow(_:)` is invoked and if so will be populated upon receiving network data.
    /// In such a case, filtering on the flow may still be performed based on its socket type, socket family or socket protocol.
    public var remoteFlowEndpoint: NWEndpoint? { get }

    /// The flow's local endpoint.
    ///
    /// This endpoint may be nil when `NEFilterDataProvider.handleNewFlow(_:)` is invoked and if so will be populated upon receiving network data.
    /// In such a case, filtering on the flow may still be performed based on its socket type, socket family or socket protocol.
    public var localFlowEndpoint: NWEndpoint? { get }
}

public var NEFilterProviderRemediationURLFlowURLHostname: String { get }

public var NEFilterProviderRemediationURLFlowURL: String { get }

public var NEFilterProviderRemediationURLOrganization: String { get }

public var NEFilterProviderRemediationURLUsername: String { get }

/**
 * @interface NEFilterProvider
 * @discussion The NEFilterProvider class is an abstract base class that declares the programmatic interface of an
 * object that implements a socket filter.
 *
 * NEFilterProvider is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterProvider : NEProvider {

    /**
     * @method startFilterWithCompletionHandler:
     * @discussion This function is called by the framework when the content filter is being started. Subclasses must
     * override this method and perform whatever steps are necessary to start the filter.
     * @param completionHandler A block that must be called when the process of starting the filter is complete. If the
     * filter was started successfully, subclass implementations must pass the nil value to this block. If an error occurred
     * while starting the filter, sublcass implementations must pass a non-nil NSError containing more details about the error.
     */
    @available(macOS 10.15, *)
    open func startFilter(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method startFilterWithCompletionHandler:
     * @discussion This function is called by the framework when the content filter is being started. Subclasses must
     * override this method and perform whatever steps are necessary to start the filter.
     * @param completionHandler A block that must be called when the process of starting the filter is complete. If the
     * filter was started successfully, subclass implementations must pass the nil value to this block. If an error occurred
     * while starting the filter, sublcass implementations must pass a non-nil NSError containing more details about the error.
     */
    @available(macOS 10.15, *)
    open func startFilter() async throws

    /**
     * @method stopFilterWithReason:completionHandler:
     * @discussion This function is called by the framework when the content filter is being stopped. Subclasses must
     * override this method and perform whatever steps are necessary to stop the filter.
     * @param reason An NEProviderStopReason indicating why the filter is being stopped.
     * @param completionHandler A block that must be called when the process of stopping the filter is complete.
     */
    @available(macOS 10.15, *)
    open func stopFilter(with reason: NEProviderStopReason, completionHandler: @escaping @Sendable () -> Void)

    /**
     * @method stopFilterWithReason:completionHandler:
     * @discussion This function is called by the framework when the content filter is being stopped. Subclasses must
     * override this method and perform whatever steps are necessary to stop the filter.
     * @param reason An NEProviderStopReason indicating why the filter is being stopped.
     * @param completionHandler A block that must be called when the process of stopping the filter is complete.
     */
    @available(macOS 10.15, *)
    open func stopFilter(with reason: NEProviderStopReason) async

    /**
     * @property filterConfiguration
     * @discussion An NEContentFilterConfiguration object containing the current filter configuration. The value of this
     * property can change during the lifetime of a filter. Filter implementations can use KVO to be notified when the
     * configuration changes.
     */
    @available(macOS 10.15, *)
    open var filterConfiguration: NEFilterProviderConfiguration { get }

    /**
     * @method handleReport:
     * @discussion This function is called by the framework when the data provider extension returns a verdict with the report property set to True.
     *     Subclass implementations may override this method to handle the flow report.
     * @param report The report being delivered.
     */
    @available(macOS 10.15, *)
    open func handle(_ report: NEFilterReport)
}

extension NEFilterReport {

    /**
     * @typedef NEFilterReportFrequency
     * @abstract A NEFilterReportFrequency controls the frequency of periodic reports.
     */
    @available(macOS 10.15.4, *)
    public enum Frequency : Int, @unchecked Sendable {

        /** @const NEFilterReportFrequencyNone No frequency */
        case none = 0

        /** @const NEFilterReportFrequencyLow Low frequency, approximately 5 seconds */
        case low = 1

        /** @const NEFilterReportFrequencyMedium Medium frequency, approximately 1 second */
        case medium = 2

        /** @const NEFilterReportFrequencyHigh High frequency, approximately half a second */
        case high = 3
    }

    /**
     * @typedef NEFilterReportEvent
     * @abstract A NEFilterReportEvent represents the event that is being reported by the NEFilterReport.
     */
    @available(macOS 10.15, *)
    public enum Event : Int, @unchecked Sendable {

        /** @const NEFilterReportEventNewFlow The report is reporting a new flow */
        case newFlow = 1

        /** @const NEFilterReportEventDataDecision The report is reporting a pass/block decision made after analyzing some amount of a flow's data */
        case dataDecision = 2

        /** @const NEFilterReportEventFlowClosed The report is reporting that a flow has been closed */
        case flowClosed = 3

        /** @const NEFilterReportEventStatistics The report is reporting the latest statistics of the flow */
        @available(macOS 10.15.4, *)
        case statistics = 4
    }
}

/**
 * @interface NEFilterVerdict
 * @discussion The NEFilterVerdict class declares the programmatic interface for an object that is the verdict for a
 * flow of network data.
 *
 * NEFilterVerdict is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterVerdict : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property shouldReport
     * @discussion Whether or not to send a report to the control provider's -[NEFilterProvider handleReport:]
     * method when processing this verdict and when the flow is closed. Since the data provider does not need to wait
     * for a response from the control provider before continuing to process the flow, this is a more efficient way to
     * report a flow to the control provider than returning a "need rules" verdict. If the verdict originates in the
     * control provider, this property has no effect. This property applies when the action taken upon a flow is allow,
     * deny, remediate, or filterData (filterData for new flows only). Setting this flag on a verdict for a socket
     * flow will also cause the data provider's -[NEFilterProvider handleReport:] method to be called when the flow
     * is closed.
     */
    @available(macOS 10.15, *)
    open var shouldReport: Bool
}

/**
 * @interface NEFilterNewFlowVerdict
 * @discussion The NEFilterNewFlowVerdict declares the programmatic interface of an object that is the verdict for a
 * new flow of network data before any of the flow's data has been seen by the filter.
 *
 * NEFilterNewFlowVerdict is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterNewFlowVerdict : NEFilterVerdict, NSSecureCoding, NSCopying {

    /**
     * @property statisticsReportFrequency
     * @discussion The frequency at which the data provider's -[NEFilterProvider handleReport:] method is called with a NEFilterReport instance with an event of NEFilterReportEventFlowStatistics.
     *     The default value is NEFilterReportFrequencyNone, so by default no statistics are reported.
     */
    @available(macOS 10.15.4, *)
    open var statisticsReportFrequency: NEFilterReport.Frequency

    /**
     * @method allowVerdict
     * @discussion This class method returns a verdict indicating that the flow should be allowed.
     * @return The NEFilterNewFlowVerdict object.
     */
    @available(macOS 10.15, *)
    open class func allow() -> NEFilterNewFlowVerdict

    /**
     * @method dropVerdict
     * @discussion This class method returns a verdict indicating that the flow should be dropped.
     * @return The NEFilterNewFlowVerdict object.
     */
    @available(macOS 10.15, *)
    open class func drop() -> NEFilterNewFlowVerdict

    /**
     * @method filterDataVerdictWithFilterInbound:peekInboundBytes:filterOutbound:peekOutboundBytes:
     * @discussion This class method returns a new flow verdict indicating that the filter needs to make a decision about
     * a new flow after seeing a portion of the flow's data.
     * @param filterInbound A boolean indicating if the filter needs to see inbound data
     * @param peekInboundBytes The number of inbound bytes that the filter needs to see in the subsequent call to
     * -[NEFilterDataProvider handleInboundDataFromFlow:readBytesStartOffset:readBytes:].
     * @param filterOutbound  boolean indicating if the filter needs to see outbound data
     * @param peekOutboundBytes The number of outbound bytes that the filter needs to see in the subsequent call to
     * -[NEFilterDataProvider handleOutboundDataFromFlow:readBytesStartOffset:readBytes:].
     * @return The new flow verdict.
     */
    @available(macOS 10.15, *)
    open class func filterDataVerdict(withFilterInbound filterInbound: Bool, peekInboundBytes: Int, filterOutbound: Bool, peekOutboundBytes: Int) -> NEFilterNewFlowVerdict

    /**
     * @method pauseVerdict
     * @discussion This class method returns a verdict indicating that none of the data provider's handler callbacks shall be called for the flow until after the flow is resumed
     *     by a call to -[NEFilterDataProvider resumeFlow:withVerdict:]. TCP flows may be paused indefinitely. UDP flows will be dropped if not resumed within 10 seconds of
     *     being paused. It is invalid to pause a flow that is already paused.
     * @return The NEFilterNewFlowVerdict object.
     */
    @available(macOS 10.15, *)
    open class func pause() -> NEFilterNewFlowVerdict
}

/**
 * @typedef NEFilterAction
 * @abstract A NEFilterAction represents the possible actions taken upon a NEFilterFlow that can be reported by the
 * data provider extension to the control provider extension.
 */
@available(macOS 10.15, *)
public enum NEFilterAction : Int, @unchecked Sendable {

    /** @const NEFilterActionInvalid Invalid action, represents an error */
    @available(macOS 10.15, *)
    case invalid = 0

    /** @const NEFilterActionAllow Allowing the flow */
    @available(macOS 10.15, *)
    case allow = 1

    /** @const NEFilterActionDrop Dropping the flow */
    @available(macOS 10.15, *)
    case drop = 2

    /** @const NEFilterActionRemediate Remediating the flow (a "content blocked" page displayed to the user) */
    case remediate = 3

    /** @const NEFilterActionFilterData Filtering data on the flow */
    @available(macOS 10.15, *)
    case filterData = 4
}

/**
 * @interface NEFilterReport
 * @discussion The NEFilterReport declares the programmatic interface of an object that is a report of actions taken by
 * the data provider.
 *
 * NEFilterReport is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterReport : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property flow
     * @discussion The flow on which the described action was taken.
     */
    @available(macOS 10.15, *)
    open var flow: NEFilterFlow? { get }

    /**
     * @property action
     * @discussion The action taken upon the reported flow.
     */
    @available(macOS 10.15, *)
    open var action: NEFilterAction { get }

    /**
     * @property event
     * @discussion The type of event that the report is reporting.
     */
    @available(macOS 10.15, *)
    open var event: NEFilterReport.Event { get }

    /**
     * @property bytesInboundCount
     * @discussion The number of inbound bytes received from the flow. This property is only non-zero when the report event is NEFilterReportEventFlowClosed or NEFilterReportEventFlowStatistics.
     */
    @available(macOS 10.15, *)
    open var bytesInboundCount: Int { get }

    /**
     * @property bytesOutboundCount
     * @discussion The number of outbound bytes sent on the flow. This property is only non-zero when the report event is NEFilterReportEventFlowClosed or NEFilterReportEventFlowStatistics.
     */
    @available(macOS 10.15, *)
    open var bytesOutboundCount: Int { get }
}

/**
 * @typedef NEFilterDataAttribute
 * @abstract Attribute flags describing data
 */
@available(macOS 10.15.5, *)
public enum NEFilterDataAttribute : Int, @unchecked Sendable {

    /** @const NEFilterDataAttributeHasIPHeader IP header is included in data */
    case hasIPHeader = 1
}

/**
 * @interface NEFilterDataProvider
 * @discussion The NEFilterDataProvider class declares the programmatic interface for an object that evaluates network data flows based on a set of locally-available rules and makes decisions about whether to block or allow the flows.
 */
@available(macOS 10.15, *)
open class NEFilterDataProvider : NEFilterProvider {

    /**
     * @method handleNewFlow:
     * @discussion This function is called by the framework when a filtering decision needs to be made about a new network data flow. Subclasses must override this method to implement the steps necessary to match the flow against some locally stored rules and return an appropriate verdict.
     * @param flow An NEFilterFlow object containing details about the new flow.
     * @return An NEFilterNewFlowVerdict object containing the verdict for the new flow.
     */
    @available(macOS 10.15, *)
    open func handleNewFlow(_ flow: NEFilterFlow) -> NEFilterNewFlowVerdict

    /**
     * @method handleInboundDataFromFlow:readBytesStartOffset:readBytes:
     * @discussion This function is called by the framework when a filtering decision needs to be made about some inbound data that the filter previously requested access to via the NEFilterFlowDataVerdict or the NEFilterNewFlowVerdict. Subclasses must override this method.
     * @param flow The NEFilterFlow from which the data was read.
     * @param offset The offset in bytes from the start of the flow's inbound data at which readBytes begins.
     * @param readBytes The data that was read.  For non-UDP/TCP flows, since data may optionally include the IP header, readBytes includes a 4-bytes NEFilterDataAttribute field preceding the user data.  Handler must examine the NEFilterDataAttribute field and handle the data accordingly.
     * @return An NEFilterFlowDataVerdict containing the verdict for the flow.
     */
    @available(macOS 10.15, *)
    open func handleInboundData(from flow: NEFilterFlow, readBytesStartOffset offset: Int, readBytes: Data) -> NEFilterDataVerdict

    /**
     * @method handleOutboundDataFromFlow:readBytesStartOffset:readBytes:
     * @discussion This function is called by the framework when a filtering decision needs to be made about some outbound data that the filter previously requested access to via the NEFilterFlowDataVerdict or the NEFilterNewFlowVerdict. Subclasses must override this method.
     * @param flow The NEFilterFlow from which the data was read.
     * @param offset The offset in bytes from the start of the flow's outbound data at which readBytes begins.
     * @param readBytes The data that was read.  For non-UDP/TCP flows, since data may optionally include the IP header, readBytes includes a 4-bytes NEFilterDataAttribute field preceding the user data.  Handler must examine the NEFilterDataAttribute field and handle the data accordingly.
     * @return An NEFilterFlowDataVerdict containing the verdict for the flow.
     */
    @available(macOS 10.15, *)
    open func handleOutboundData(from flow: NEFilterFlow, readBytesStartOffset offset: Int, readBytes: Data) -> NEFilterDataVerdict

    /**
     * @method handleInboundDataCompleteForFlow:
     * @discussion This function is called by the framework after all of the inbound data for a flow has been seen by the filter. Subclasses must override this method to return an appropriate pass/block result.
     * @param flow The flow
     * @return The final NEFilterFlowDataVerdict verdict for the flow.
     */
    @available(macOS 10.15, *)
    open func handleInboundDataComplete(for flow: NEFilterFlow) -> NEFilterDataVerdict

    /**
     * @method handleOutboundDataCompleteForFlow:
     * @discussion This function is called by the framework after all of the outbound data for a flow has been seen by the filter. Subclasses must override this method to return an appropriate pass/block result.
     * @param flow The flow
     * @return The final NEFilterFlowDataVerdict verdict for the flow.
     */
    @available(macOS 10.15, *)
    open func handleOutboundDataComplete(for flow: NEFilterFlow) -> NEFilterDataVerdict

    /**
     * @method applyFilterRules:defaultAction:withCompletionHandler:
     * @discussion The provider calls this function to apply the current set of filtering rules associated with the provider and also change the default filtering action.
     * @param settings A NEFilterSettings object containing the filter settings to apply to the system. Pass nil to revert to the default settings, which are an
     *     empty list of rules and a default action of NEFilterActionFilterData.
     * @param completionHandler A block that will be executed when the settings have been applied to the system. If an error occurs then the error parameter will be non-nil.
     */
    @available(macOS 10.15, *)
    open func apply(_ settings: NEFilterSettings?, completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method applyFilterRules:defaultAction:withCompletionHandler:
     * @discussion The provider calls this function to apply the current set of filtering rules associated with the provider and also change the default filtering action.
     * @param settings A NEFilterSettings object containing the filter settings to apply to the system. Pass nil to revert to the default settings, which are an
     *     empty list of rules and a default action of NEFilterActionFilterData.
     * @param completionHandler A block that will be executed when the settings have been applied to the system. If an error occurs then the error parameter will be non-nil.
     */
    @available(macOS 10.15, *)
    open func apply(_ settings: NEFilterSettings?) async throws

    /**
     * @method resumeFlow:withVerdict:
     * @discussion This function is called by the provider to resume a flow that was previously paused by the provider returning a pause verdict.
     * @param flow The flow to resume
     * @param verdict The next NEFilterDataVerdict for the flow. This verdict is used as the verdict corresponding to the
     *    flow handler callback (handleNewFlow:, handleInboundDataFromFlow:, etc.) that returned the pause verdict that
     *    paused the flow. This must be either a NEFilterDataVerdict or a NEFilterNewFlowVerdict. It is invalid to resume
     *    a flow that is not paused.
     */
    @available(macOS 10.15, *)
    open func resumeFlow(_ flow: NEFilterFlow, with verdict: NEFilterVerdict)

    /**
     * @method updateFlow:withVerdict:forDirection:
     * @discussion This function is called by the provider to update the verdict for a flow outside the context of any NEFilterDataProvider callback.
     * @param flow The NEFilterSocketFlow to update the verdict for.
     * @param verdict The NEFilterDataVerdict. Must be a +[NEFilterDataVerdict allowVerdict], a +[NEFilterDataVerdict dropVerdict], or a +[NEFilterDataVerdict dataVerdictWithPassBytes:peekBytes:].
     * @param direction The direction to which the verdict applies. Pass NETrafficDirectionAny to update the verdict for both the inbound and outbound directions. This parameter is ignored if the verdict is +[NEFilterDataVerdict dropVerdict].
     */
    @available(macOS 10.15.4, *)
    open func update(_ flow: NEFilterSocketFlow, using verdict: NEFilterDataVerdict, for direction: NETrafficDirection)
}

/**
 * @interface NEFilterDataVerdict
 * @discussion The NEFilterDataVerdict class declares the programmatic interface of an object that is the verdict for a flow of network data after some of the data has been seen by the filter.
 *
 * NEFilterDataVerdict is part of NetworkExtension.framework
 */
@available(macOS 10.15, *)
open class NEFilterDataVerdict : NEFilterVerdict, NSSecureCoding, NSCopying {

    /**
     * @property statisticsReportFrequency
     * @discussion The frequency at which the data provider's -[NEFilterProvider handleReport:] method is called with a NEFilterReport instance with an event of NEFilterReportEventFlowStatistics.
     *     The default value is NEFilterReportFrequencyNone, so by default no statistics are reported.
     */
    @available(macOS 10.15.4, *)
    open var statisticsReportFrequency: NEFilterReport.Frequency

    /**
     * @method allowVerdict
     * @discussion This class method returns a verdict indicating that the flow should be allowed.
     * @return The NEFilterDataVerdict object.
     */
    @available(macOS 10.15, *)
    open class func allow() -> NEFilterDataVerdict

    /**
     * @method dropVerdict
     * @discussion This class method returns a verdict indicating that the flow should be dropped.
     * @return The NEFilterDataVerdict object.
     */
    @available(macOS 10.11, *)
    open class func drop() -> NEFilterDataVerdict

    /**
     * @method dataVerdictWithPassBytes:peekBytes:
     * @discussion This class method returns a data verdict indicating that the filter is passing a given number of bytes through the filter and needs to see a given number of bytes after the bytes that are passed.
     * @param passBytes The number of bytes to pass through the filter.
     * @param peekBytes The number of bytes after the end of the bytes passed that the filter wants to see in the next call to -[NEFilterDataProvider handleOutboundDataFromFlow:readBytesStartOffset:readBytes:] or -[NEFilterDataProvider handleInboundDataFromFlow:readBytesStartOffset:readBytes:].
     * @return The data flow verdict.
     */
    @available(macOS 10.15, *)
    public /*not inherited*/ init(passBytes: Int, peekBytes: Int)

    /**
     * @method pauseVerdict
     * @discussion This class method returns a verdict indicating that none of the data provider's handler callbacks shall be called for the flow until after the flow is resumed
     *     by a call to -[NEFilterDataProvider resumeFlow:withVerdict:]. TCP flows may be paused indefinitely. UDP flows will be dropped if not resumed within 10 seconds of
     *     being paused. It is invalid to pause a flow that is already paused.
     * @return The NEFilterDataVerdict object.
     */
    @available(macOS 10.15, *)
    open class func pause() -> NEFilterDataVerdict
}

/**
 * @typedef NEFilterManagerError
 * @abstract Filter error codes
 */
@available(macOS 10.11, *)
public enum NEFilterManagerError : Int, @unchecked Sendable {

    /** @const NEFilterManagerErrorConfigurationInvalid The filter configuration is invalid */
    case configurationInvalid = 1

    /** @const NEFilterManagerErrorConfigurationDisabled The filter configuration is not enabled. */
    case configurationDisabled = 2

    /** @const NEFilterManagerErrorConfigurationStale The filter configuration needs to be loaded. */
    case configurationStale = 3

    /** @const NEFilterManagerErrorConfigurationCannotBeRemoved The filter configuration cannot be removed. */
    case configurationCannotBeRemoved = 4

    /** @const NEFilterManagerErrorConfigurationPermissionDenied Operation permission denied. */
    @available(macOS 10.15, *)
    case configurationPermissionDenied = 5

    /** @const NEFilterManagerErrorConfigurationInternalError An internal configuration error occurred. */
    @available(macOS 10.15, *)
    case configurationInternalError = 6
}

/** @const NEFilterErrorDomain The filter error domain */
@available(macOS 10.11, *)
public let NEFilterErrorDomain: String

extension NEFilterManager {

    /**
     * @typedef NEFilterManagerGrade
     * @abstract Filter grade
     */
    @available(macOS 10.15, *)
    public enum Grade : Int, @unchecked Sendable {

        /** @const NEFilterManagerGradeFirewall The filter acts as a firewall, blocking some network traffic. Firewall grade filters see network traffic before other filter grades. */
        case firewall = 1

        /** @const NEFilterManagerGradeInspector The filter acts as an inspector of network traffic. Inspector grade filters see network traffic after firewall grade filters. */
        case inspector = 2
    }
}

/**
 * @interface NEFilterManager
 * @discussion The NEFilterManager class declares the programmatic interface for an object that manages content filtering configurations.
 *
 * NEFilterManager declares methods and properties for configuring and controlling a filter.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEFilterManager : NSObject {

    /**
     * @method sharedManager
     * @return The singleton NEFilterManager object for the calling process.
     */
    @available(macOS 10.11, *)
    open class func shared() -> NEFilterManager

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current filter configuration from the caller's filter preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func loadFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current filter configuration from the caller's filter preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func loadFromPreferences() async throws

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the filter configuration from the caller's filter preferences. If the filter is enabled, the filter becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func removeFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the filter configuration from the caller's filter preferences. If the filter is enabled, the filter becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func removeFromPreferences() async throws

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the filter configuration in the caller's filter preferences. If the filter is enabled, it will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func saveToPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the filter configuration in the caller's filter preferences. If the filter is enabled, it will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.11, *)
    open func saveToPreferences() async throws

    /**
     * @property localizedDescription
     * @discussion A string containing a description of the filter.
     */
    @available(macOS 10.11, *)
    open var localizedDescription: String?

    /**
     * @property providerConfiguration
     * @discussion An NEFilterProviderConfiguration object containing the provider-specific portion of the filter configuration.
     */
    @available(macOS 10.11, *)
    open var providerConfiguration: NEFilterProviderConfiguration?

    /**
     * @property enabled
     * @discussion Toggles the enabled status of the filter. On iOS, setting this property will disable filter configurations of other apps, and this property will be set to NO when other filter configurations are enabled.
     *     On macOS, up to 4 filter configurations of the same grade can be enabled simultaneously.
     */
    @available(macOS 10.11, *)
    open var isEnabled: Bool

    /**
     * @property grade
     * @discussion The grade of the filter. The default grade is NEFilterManagerGradeFirewall.
     */
    @available(macOS 10.15, *)
    open var grade: NEFilterManager.Grade

    /**
     * @property disableEncryptedDNSSettings
     * @discussion Causes the content filter to disable any other installed encrypted DNS settings, including iCloud Private Relay system-wide DNS encryption. This should only be used if
     * the content filter expects to intercept cleartext UDP DNS packets.
     */
    @available(macOS 15.0, *)
    open var disableEncryptedDNSSettings: Bool
}

/**
 * @interface NEFilterPacketContext
 * @discussion The NEFilterPacketContext class identifies the current filtering context.
 */
@available(macOS 10.15, *)
open class NEFilterPacketContext : NSObject {
}

extension NEFilterPacketProvider {

    /**
     * @typedef NEFilterPacketProviderVerdict
     * @abstract Verdict for a packet
     */
    @available(macOS 10.15, *)
    public enum Verdict : Int, @unchecked Sendable {

        /** @const NEFilterPacketProviderVerdictAllow Allow a packet */
        case allow = 0

        /** @const NEFilterPacketProviderVerdictDrop Drop a packet */
        case drop = 1

        case delay = 2
    }
}

/**
 * @typedef NEFilterPacketHandler
 * @discussion A block that makes a filtering decision about a network packet.
 * @param context The context of the current packet filter.
 * @param interface The ingress or egress interface of the packet.
 * @param direction The direction of the packet.
 * @param packetBytes The packet bytes.
 * @param packetLength The length of packetBytes.
 * @return A NEFilterPacketProviderVerdict. If the returned verdict is NEFilterPacketProviderVerdictDelay, then the framework assumes that the block already called -[NEFilterPacketProvider delayCurrentPacket] to obtain a reference to the packet.
 */
@available(macOS 10.15, *)
public typealias NEFilterPacketHandler = (NEFilterPacketContext, nw_interface_t, NETrafficDirection, UnsafeRawPointer, Int) -> NEFilterPacketProvider.Verdict

/**
 * @interface NEFilterPacketProvider
 * @discussion The NEFilterPacketProvider class declares the programmatic interface for an object that evaluates network packets decisions about whether to block, allow, or delay the packets.
 */
@available(macOS 10.15, *)
open class NEFilterPacketProvider : NEFilterProvider {

    /**
     * @property packetHandler
     * @discussion A block to be set to handle each packet received or to be sent.  A verdict
     *             to allow, drop or delay must be returned to indicate the treatment of
     *             the packet.  Since there may be multiple filtering sources presenting
     *             frames to the provider, this packet handler may be executed by multiple
     *               simultaneous threads.  This packet handler must be able to handle execution
     *               in a multi-threaded environment.
     */
    @available(macOS 10.15, *)
    open var packetHandler: NEFilterPacketHandler?

    /**
     * @method delayCurrentPacket
     * @discussion This function is used to delay a packet currently presented by packetHandler.
     *             This function is only valid within the packetHandler block and a verdict of
     *             NEFilterPacketProviderVerdictDelay must be returned after a packet is delayed.  A delayed
     *             packet will be prevented from continuing its journey through the networking stack until
     *             it is either allowed by calling allow() or is dropped by being released.
     * @param context The context of the current packet filter which is passed to the packetHandler block.
     *           The packetHandler block must pass this context when calling delayCurrentPacket().
     */
    @available(macOS 10.15, *)
    open func delayCurrentPacket(_ context: NEFilterPacketContext) -> NEPacket

    /**
     * @method allowPacket:
     * @discussion This function is used to allow a previously-delayed packet to continue its journey into or out of the networking stack.
     * @param packet A NEPacket object that contains the data of the packet that was previously delayed by the NEFilterPacketProvider.
     */
    @available(macOS 10.15, *)
    open func allow(_ packet: NEPacket)
}

@available(macOS 15.0, *)
@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension NEFilterPacketProvider {

    /// A closure to be set to handle each packet received or to be sent. A verdict to allow, drop or delay must be returned to indicate the treatment of the packet.
    ///
    /// Since there may be multiple filtering sources presenting frames to the provider, this packet handler may be executed by multiple simultaneous threads. This packet handler must be able to handle execution in a multi-threaded environment.
    public var handler: ((NEFilterPacketContext, NWInterface, NETrafficDirection, UnsafeRawBufferPointer) -> NEFilterPacketProvider.Verdict)?
}

/**
 * @interface NEFilterProviderConfiguration
 * @discussion The NEFilterProviderConfiguration class declares the programmatic interface of an object that configures a plugin-based content filter.
 */
@available(macOS 10.11, *)
open class NEFilterProviderConfiguration : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property filterBrowsers
     * @discussion If YES, the filter plugin will be allowed to filter browser traffic. If NO, the filter plugin will not see any browser flows. Defaults to NO. At least one of filterBrowsers and filterSockets should be set to YES to make the filter take effect.
     */
    @available(macOS, introduced: 10.11, deprecated: 10.15, message: "filterBrowsers is not supported on macOS")
    open var filterBrowsers: Bool

    /**
     * @property filterSockets
     * @discussion If YES, the filter plugin will be allowed to filter socket traffic. If NO, the filter plugin will not see any socket flows. Defaults to NO. At least one of filterBrowsers and filterSockets should be set to YES to make the filter take effect.
     */
    @available(macOS 10.15, *)
    open var filterSockets: Bool

    /**
     * @property filterPackets
     * @discussion If YES, a NEFilterPacketProvider will be instantiated and will be allowed to filter packets.
     */
    @available(macOS 10.15, *)
    open var filterPackets: Bool

    /**
     * @property vendorConfiguration
     * @discussion An optional dictionary of plugin-specific keys to be passed to the plugin.
     */
    @available(macOS 10.11, *)
    open var vendorConfiguration: [String : Any]?

    /**
     * @property serverAddress
     * @discussion The optional address of the server used to support the filter.
     */
    @available(macOS 10.11, *)
    open var serverAddress: String?

    /**
     * @property username
     * @discussion The optional username associated with the filter.
     */
    @available(macOS 10.11, *)
    open var username: String?

    /**
     * @property organization
     * @discussion The optional organization associated with the filter.
     */
    @available(macOS 10.11, *)
    open var organization: String?

    /**
     * @property passwordReference
     * @discussion The optional password keychain reference associated with the filter.
     */
    @available(macOS 10.11, *)
    open var passwordReference: Data?

    /**
     * @property identityReference
     * @discussion The optional certificate identity keychain reference associated with the filter.
     */
    @available(macOS 10.11, *)
    open var identityReference: Data?

    /**
     * @property filterDataProviderBundleIdentifier
     * @discussion A string containing the bundle identifier of the NEFilterDataProvider app extension or system extension.
     *     If this property is nil, then the bundle identifier of the NEFilterDataProvider extension in the calling app's
     *     bundle is used, and if the calling app's bundle contains more than one NEFilterDataProvider extension then which one will
     *     be used is undefined.
     */
    @available(macOS 10.15, *)
    open var filterDataProviderBundleIdentifier: String?

    /**
     * @property filterPacketProviderBundleIdentifier
     * @discussion A string containing the bundle identifier of the NEFilterPacketProvider app extension or system extension.
     *     If this property is nil, then the bundle identifier of the NEFilterPacketProvider extension in the calling app's
     *     bundle is used, and if the calling app's bundle contains more than one NEFilterPacketProvider extension then which one will
     *     be used is undefined.
     */
    @available(macOS 10.15, *)
    open var filterPacketProviderBundleIdentifier: String?
}

/**
 * @interface NEFilterRule
 * @discussion The NEFilterRule class declares the programmatic interface of an object that defines a rule for matching network traffic and the action to take when the rule matches.
 */
@available(macOS 10.15, *)
open class NEFilterRule : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithNetworkRule:action:
     * @discussion Initialize a newly-allocated NEFilterRule object
     * @param networkRule A NENetworkRule object that defines the network traffic characteristics that this rule matches.
     * @param action The action to take when this rule matches.
     */
    @available(macOS 10.15, *)
    public init(networkRule: NENetworkRule, action: NEFilterAction)

    /**
     * @property matchNetworkRule
     * @discussion The NENetworkRule that defines the network traffic characteristics that this rule matches.
     */
    @available(macOS 10.15, *)
    @NSCopying open var networkRule: NENetworkRule { get }

    /**
     * @property action
     * @discussion The action to take when this rule matches network traffic.
     */
    @available(macOS 10.15, *)
    open var action: NEFilterAction { get }
}

/**
 * @interface NEFilterSettings
 * @discussion The NEFilterSettings class declares the programmatic interface for an object that contains filter settings.
 *
 * NEFilterSettings is used by NEFilterDataProviders to communicate the desired settings for the filter to the framework. The framework takes care of applying the contained settings to the system.
 */
@available(macOS 10.15, *)
open class NEFilterSettings : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithRules:defaultAction:
     * @discussion Initialize a newly-allocated NEFilterSettings object with a set of filtering rules and a default filter action to takke if none
     *    of the rules match.
     * @param rules An NSArray containing an ordered list of NEFilterRule objects. The maximum number of rules that this array can contain is 1000.
     * @param defaultAction The NEFilterAction to take for flows of network (non-loopback) data that do not match any of the specified rules. The default defaultAction is
     *     NEFilterActionFilterData. If defaultAction is NEFilterActionAllow or NEFilterActionDrop, then the rules array must contain at least one NEFilterRule.
     *     The default action for loopback traffic is NEFilterActionAllow and cannot be changed. To filter loopback traffic you must include rules in the rules array that specifically match loopback traffic
     *     and have an action of NEFilterActionFilterData.
     * @return the newly-initialized NEFilterSettings object.
     */
    @available(macOS 10.15, *)
    public init(rules: [NEFilterRule], defaultAction: NEFilterAction)

    /**
     * @property rules
     * @discussion An NSArray containing an ordered list of NEFilterRuleObjects. After the NEFilterSettings are applied to the system,
     *     each network flow is matched against these rules in order, and the NEFilterAction of the first rule that matches is taken:
     *         NEFilterActionAllow: Allow the flow of data to proceed on its journey through the networking stack without consulting this provider.
     *         NEFilterActionDrop: Drop the flow without consulting this provider.
     *         NEFilterActionFilterData: Call this provider's handleNewFlow: method with the flow.
     */
    @available(macOS 10.15, *)
    open var rules: [NEFilterRule] { get }

    /**
     * @property defaultAction
     * @discussion An NEFilterAction containing the default action to take for flows of network data that do not match any of the specified rules.
     */
    @available(macOS 10.15, *)
    open var defaultAction: NEFilterAction { get }
}

/**
 * @interface NEFlowMetaData
 * @discussion The NEFlowMetaData class declares the programmatic interface for an object that contains extra information about a flow.
 */
@available(macOS 10.11, *)
open class NEFlowMetaData : NSObject, NSCopying, NSSecureCoding {

    /**
     * @property sourceAppUniqueIdentifier
     * @discussion A byte string that uniquely identifies the binary for each build of the source application of the flow. The data object may be empty in cases where the flow originates from a system process.
     */
    @available(macOS 10.11, *)
    open var sourceAppUniqueIdentifier: Data { get }

    /**
     * @property sourceAppSigningIdentifier
     * @discussion A string containing the signing identifier (almost always equivalent to the bundle identifier) of the source app of the flow. The string may be empty in cases where the flow originates from a system process.
     */
    @available(macOS 10.11, *)
    open var sourceAppSigningIdentifier: String { get }

    /**
     *    @property sourceAppAuditToken
     *    @discussion Audit token of the source application of the flow.
     */
    @available(macOS 10.15, *)
    open var sourceAppAuditToken: Data? { get }

    /**
     * @property filterFlowIdentifier
     * @discussion The identifier of the content filter flow corresponding to this flow.
     */
    @available(macOS 10.15.4, *)
    open var filterFlowIdentifier: UUID? { get }
}

/**
 * @interface NEIPv4Settings
 * @discussion The NEIPv4Settings class declares the programmatic interface for an object that contains IPv4 settings.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEIPv4Settings : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithAddresses:subnetMasks:
     * @discussion Initialize a newly-allocated NEIPv4Settings object.
     * @param addresses An array of IPv4 addresses represented as dotted decimal strings.
     * @param subnetMasks An array of IPv4 subnet masks represented as dotted decimal strings.
     * @return The initialized object.
     */
    @available(macOS 10.11, *)
    public init(addresses: [String], subnetMasks: [String])

    /**
     * @property addresses
     * @discussion An array of IPv4 addresses represented as dotted decimal strings. These addresses will be set on the virtual interface used by the VPN tunnel.
     */
    @available(macOS 10.11, *)
    open var addresses: [String] { get }

    /**
     * @property subnetMasks
     * @discussion An array of IPv4 subnet masks represented as dotted decimal strings. These subnet masks will be set along with their corresponding addresses from the addresses array on the virtual interface used by the VPN tunnel.
     */
    @available(macOS 10.11, *)
    open var subnetMasks: [String] { get }

    /**
     * @property router
     * @discussion The address of the next-hop gateway router represented as a dotted decimal string. This property is ignored for TUN interfaces.
     */
    @available(macOS 13.0, *)
    open var router: String?

    /**
     * @property includedRoutes
     * @discussion An array of NEIPv4Route objects. Traffic matching these routes will be routed through the virtual interface used by the VPN tunnel.
     */
    @available(macOS 10.11, *)
    open var includedRoutes: [NEIPv4Route]?

    /**
     * @property excludedRoutes
     * @discussion An array of NEIPv4Route objects. Traffic matching these routes will be routed through the current primary physical interface of the device.
     */
    @available(macOS 10.11, *)
    open var excludedRoutes: [NEIPv4Route]?
}

/**
 * @interface NEIPv4Route
 * @discussion The NEIPv4Route class declares the programmatic interface for an object that contains settings for an IPv4 route.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEIPv4Route : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithDestinationAddress:subnetMask:
     * @discussion Initialize a newly-allocated NEIPv4Route.
     * @param address The IPv4 address of the destination network.
     * @param subnetMask The subnet mask of the destination network.
     * @return The initialized NEIPv4Route.
     */
    @available(macOS 10.11, *)
    public init(destinationAddress address: String, subnetMask: String)

    /**
     * @property destinationAddress
     * @discussion An IPv4 address represented as a dotted decimal string.
     */
    @available(macOS 10.11, *)
    open var destinationAddress: String { get }

    /**
     * @property destinationSubnetMask
     * @discussion An IPv4 subnet mask represented as a dotted decimal string. This mask in combination with the destinationAddress property is used to determine the destination network of the route.
     */
    @available(macOS 10.11, *)
    open var destinationSubnetMask: String { get }

    /**
     * @property gatewayAddress
     * @discussion The IPv4 address of the route's gateway. If this property is nil then the route's gateway will be set to the tunnel's virtual interface.
     */
    @available(macOS 10.11, *)
    open var gatewayAddress: String?

    /**
     * @method defaultRoute
     * @return A route object that represents the IPv4 default route.
     */
    @available(macOS 10.11, *)
    open class func `default`() -> NEIPv4Route
}

/**
 * @interface NEIPv6Settings
 * @discussion The NEIPv6Settings class declares the programmatic interface for an object that contains IPv6 settings.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEIPv6Settings : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithAddresses:networkPrefixLengths:
     * @discussion Initialize a newly-allocated NEIPv6Settings object.
     * @param addresses An array of IPv6 addresses represented as dotted decimal strings.
     * @param networkPrefixLengths An array of NSNumber objects each containing the length in bits of the network prefix of the corresponding address in the addresses parameter.
     * @return The initialized object.
     */
    @available(macOS 10.11, *)
    public init(addresses: [String], networkPrefixLengths: [NSNumber])

    /**
     * @property addresses
     * @discussion An array of IPv6 addresses represented strings. These addresses will be set on the virtual interface used by the VPN tunnel.
     */
    @available(macOS 10.11, *)
    open var addresses: [String] { get }

    /**
     * @property networkPrefixLengths
     * @discussion An array of NSNumber objects each representing the length in bits of the network prefix of the corresponding address in the addresses property.
     */
    @available(macOS 10.11, *)
    open var networkPrefixLengths: [NSNumber] { get }

    /**
     * @property includedRoutes
     * @discussion An array of NEIPv6Route objects. Traffic matching these routes will be routed through the virtual interface used by the VPN tunnel.
     */
    @available(macOS 10.11, *)
    open var includedRoutes: [NEIPv6Route]?

    /**
     * @property excludedRoutes
     * @discussion An array of NEIPv6Route objects. Traffic matching these routes will be routed through the current primary physical interface of the device.
     */
    @available(macOS 10.11, *)
    open var excludedRoutes: [NEIPv6Route]?
}

/**
 * @interface NEIPv6Route
 * @discussion The NEIPv6Route class declares the programmatic interface for an object that contains settings for an IPv6 route.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEIPv6Route : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithDestinationAddress:networkPrefixLength:
     * @discussion Initialize a newly-allocated NEIPv6Route.
     * @param address The IPv6 address of the destination network.
     * @param networkPrefixLength A number containing the length in bits of the network prefix of the destination network.
     * @return The initialized NEIPv6Route.
     */
    @available(macOS 10.11, *)
    public init(destinationAddress address: String, networkPrefixLength: NSNumber)

    /**
     * @property destinationAddress
     * @discussion An IPv6 address represented as a string.
     */
    @available(macOS 10.11, *)
    open var destinationAddress: String { get }

    /**
     * @property destinationNetworkPrefixLength
     * @discussion A number containing the length in bits of the network prefix of the destination network. This prefix in combination with the destinationAddress property is used to determine the destination network of the route.
     */
    @available(macOS 10.11, *)
    open var destinationNetworkPrefixLength: NSNumber { get }

    /**
     * @property gatewayAddress
     * @discussion The IPv6 address of the route's gateway. If this property is nil then the route's gateway will be set to the tunnel's virtual interface.
     */
    @available(macOS 10.11, *)
    open var gatewayAddress: String?

    /**
     * @method defaultRoute
     * @return A route object that represents the IPv6 default route.
     */
    @available(macOS 10.11, *)
    open class func `default`() -> NEIPv6Route
}

/**
 * @interface NETunnelNetworkSettings
 * @discussion The NETunnelNetworkSettings class declares the programmatic interface for an object that contains network settings.
 *
 * NETunnelNetworkSettings is used by NETunnelProviders to communicate the desired network settings for the tunnel to the framework. The framework takes care of applying the contained settings to the system.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NETunnelNetworkSettings : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithTunnelRemoteAddress:
     * @discussion This function initializes a newly-allocated NETunnelNetworkSettings object with a given tunnel remote address.
     * @param address The address of the remote endpoint that is providing the tunnel service.
     */
    @available(macOS 10.11, *)
    public init(tunnelRemoteAddress address: String)

    /**
     * @property tunnelRemoteAddress
     * @discussion A string containing the IP address of the remote endpoint that is providing the tunnel service.
     */
    @available(macOS 10.11, *)
    open var tunnelRemoteAddress: String { get }

    /**
     * @property DNSSettings
     * @discussion An NEDNSSettings object that contains the desired tunnel DNS settings.
     */
    @available(macOS 10.11, *)
    @NSCopying open var dnsSettings: NEDNSSettings?

    /**
     * @property proxySettings
     * @discussion An NEProxySettings object that contains the desired tunnel proxy settings.
     */
    @available(macOS 10.11, *)
    @NSCopying open var proxySettings: NEProxySettings?
}

/**
 * @interface NEPacketTunnelNetworkSettings
 * @discussion The NEPacketTunnelNetworkSettings class declares the programmatic interface for an object that contains IP network settings.
 *
 * NEPacketTunnelNetworkSettings is used by NEPacketTunnelProviders to communicate the desired IP network settings for the packet tunnel to the framework. The framework takes care of applying the contained settings to the system.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEPacketTunnelNetworkSettings : NETunnelNetworkSettings {

    /**
     * @property IPv4Settings
     * @discussion An NEIPv4Settings object that contains the desired tunnel IPv4 settings.
     */
    @available(macOS 10.11, *)
    @NSCopying open var ipv4Settings: NEIPv4Settings?

    /**
     * @property IPv6Settings
     * @discussion An NEIPv6Settings object that contains the desired tunnel IPv6 settings.
     */
    @available(macOS 10.11, *)
    @NSCopying open var ipv6Settings: NEIPv6Settings?

    /**
     * @property tunnelOverheadBytes
     * @discussion An NSNumber object containing the number of bytes of overhead appended to each outbound packet through the tunnel. The MTU for the TUN interface is computed by subtracting this value from the MTU of the primary physical interface.
     */
    @available(macOS 10.11, *)
    @NSCopying open var tunnelOverheadBytes: NSNumber?

    /**
     * @property MTU
     * @discussion An NSNumber object containing the Maximum Transmission Unit (MTU) size in bytes to assign to the TUN interface. If this property is set, the tunnelOverheadBytes property is ignored.
     */
    @available(macOS 10.11, *)
    @NSCopying open var mtu: NSNumber?
}

/**
 * @interface NEEthernetTunnelNetworkSettings
 * @discussion The NEEthernetTunnelNetworkSettings class declares the programmatic interface for an object that contains network settings.
 *
 * NEEthernetTunnelNetworkSettings is used by NEEthernetTunnelProviders to communicate the desired network settings for the packet tunnel to the framework. The framework takes care of applying the contained settings to the system.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 13.0, *)
open class NEEthernetTunnelNetworkSettings : NEPacketTunnelNetworkSettings {

    /**
     * @method initWithTunnelRemoteAddress:
     * @discussion This function initializes a newly-allocated NEEthernetTunnelNetworkSettings object with a given tunnel remote address and MAC address.
     * @param address The address of the remote endpoint that is providing the tunnel service.
     * @param ethernetAddress The ethernet address to be assigned to the tunnel interface. This string should be in the format "xx:xx:xx:xx:xx:xx", where each xx is a hexidecimal number between 0 and ff.
     * @param mtu The MTU (Maxium Transmission Unit) in bytes to be assigned to the tunnel interface.
     */
    @available(macOS 13.0, *)
    public init(tunnelRemoteAddress address: String, ethernetAddress: String, mtu: Int)

    /**
     * @property ethernetAddress
     * @discussion An NSString object containing the ethernet address of the tunnel interface.
     */
    @available(macOS 13.0, *)
    open var ethernetAddress: String { get }
}

/**
 * @interface NEPacketTunnelProvider
 * @discussion The NEPacketTunnelProvider class declares the programmatic interface of an object that implements the client side of a custom IP packet tunneling protocol.
 *
 * NEPacketTunnelProvider is part of NetworkExtension.framework.
 */
@available(macOS 10.11, *)
open class NEPacketTunnelProvider : NETunnelProvider {

    /**
     * @method startTunnelWithOptions:completionHandler:
     * @discussion This function is called by the framework when a new tunnel is being created. Subclasses must override this method to perform whatever steps are necessary to establish the tunnel.
     * @param options A dictionary containing keys and values passed by the provider's containing app. If the containing app did not start the tunnel then this parameter will be nil.
     * @param completionHandler A block that must be called when the process of starting the tunnel is complete. If the tunnel cannot be established then the subclass' implementation of this method must pass a non-nil NSError object to this block. A value of nil passed to the completion handler indicates that the tunnel was successfully established.
     */
    @available(macOS 10.11, *)
    open func startTunnel(options: [String : NSObject]? = nil, completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method startTunnelWithOptions:completionHandler:
     * @discussion This function is called by the framework when a new tunnel is being created. Subclasses must override this method to perform whatever steps are necessary to establish the tunnel.
     * @param options A dictionary containing keys and values passed by the provider's containing app. If the containing app did not start the tunnel then this parameter will be nil.
     * @param completionHandler A block that must be called when the process of starting the tunnel is complete. If the tunnel cannot be established then the subclass' implementation of this method must pass a non-nil NSError object to this block. A value of nil passed to the completion handler indicates that the tunnel was successfully established.
     */
    @available(macOS 10.11, *)
    open func startTunnel(options: [String : NSObject]? = nil) async throws

    /**
     * @method stopTunnelWithReason:completionHandler:
     * @discussion This function is called by the framework when the tunnel is being destroyed. Subclasses must override this method to perform whatever steps are necessary to tear down the tunnel.
     * @param reason An NEProviderStopReason indicating why the tunnel is being stopped.
     * @param completionHandler A block that must be called when the tunnel is completely torn down.
     */
    @available(macOS 10.11, *)
    open func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping @Sendable () -> Void)

    /**
     * @method stopTunnelWithReason:completionHandler:
     * @discussion This function is called by the framework when the tunnel is being destroyed. Subclasses must override this method to perform whatever steps are necessary to tear down the tunnel.
     * @param reason An NEProviderStopReason indicating why the tunnel is being stopped.
     * @param completionHandler A block that must be called when the tunnel is completely torn down.
     */
    @available(macOS 10.11, *)
    open func stopTunnel(with reason: NEProviderStopReason) async

    /**
     * @method cancelTunnelWithError:
     * @discussion This function is called by tunnel provider implementations to initiate tunnel destruction when a network error is encountered that renders the tunnel no longer viable. Subclasses should not override this method.
     * @param error An NSError object containing details about the error that the tunnel provider implementation encountered.
     */
    @available(macOS 10.11, *)
    open func cancelTunnelWithError(_ error: (any Error)?)

    /**
     * @property packetFlow
     * @discussion An NEPacketFlow object that the tunnel provider implementation should use to receive packets from the network stack and inject packets into the network stack. Every time the tunnel is started the packet flow object is in an initialized state and must be explicitly opened before any packets can be received or injected.
     */
    @available(macOS 10.11, *)
    open var packetFlow: NEPacketTunnelFlow { get }

    /**
     * @method createTCPConnectionThroughTunnelToEndpoint:enableTLS:TLSParameters:delegate:
     * @discussion This function can be called by subclass implementations to create a TCP connection to a given network endpoint, through the tunnel established by the provider. This function should not be overridden by subclasses.
     * @param remoteEndpoint An NWEndpoint object that specifies the remote network endpoint to connect to.
     * @param enableTLS A flag indicating if a TLS session should be negotiated on the connection.
     * @param TLSParameters A set of optional TLS parameters. Only valid if enableTLS is YES. If TLSParameters is nil, the default system parameters will be used for TLS negotiation.
     * @param delegate An object to use as the connection delegate. This object should conform to the NWTCPConnectionAuthenticationDelegate protocol.
     * @return An NWTCPConnection object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use the `virtualInterface` property with `nw_parameters_require_interface`")
    open func createTCPConnectionThroughTunnel(to remoteEndpoint: NWEndpoint, enableTLS: Bool, tlsParameters TLSParameters: NWTLSParameters?, delegate: Any?) -> NWTCPConnection

    /**
     * @method createUDPSessionThroughTunnelToEndpoint:fromEndpoint:
     * @discussion This function can be called by subclass implementations to create a UDP session between a local network endpoint and a remote network endpoint, through the tunnel established by the provider. This function should not be overridden by subclasses.
     * @param remoteEndpoint An NWEndpoint object that specifies the remote endpoint to which UDP datagrams will be sent by the UDP session.
     * @param localEndpoint An NWHostEndpoint object that specifies the local IP address endpoint to use as the source endpoint of the UDP session.
     * @return An NWUDPSession object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use the `virtualInterface` property with `nw_parameters_require_interface`")
    open func createUDPSessionThroughTunnel(to remoteEndpoint: NWEndpoint, from localEndpoint: NWHostEndpoint?) -> NWUDPSession
}

@available(macOS 15.0, iOS 18.0, tvOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
extension NEPacketTunnelProvider {

    /// The virtual network interface used to route packets to the packet tunnel provider.
    ///
    /// For NEPacketTunnelProvider sub-classes, this property will be non-nil when `NEPacketTunnelProvider.startTunnel(options:)` is called. For NEEthernetTunnelProvider sub-classes, this property will be non-nil after `NETunnelProvider.setTunnelNetworkSettings(_:)` returns. To create a connection through the tunnel, set this interface as `NWParameters.requiredInterface`.
    public var virtualInterface: NWInterface? { get }
}

/**
 * @interface NEEthernetTunnelProvider
 * @discussion The NEEthernetTunnelProvider class declares the programmatic interface of an object that implements the client side of a custom link-layer packet tunneling protocol.
 *
 * NEEthernetTunnelProvider is part of NetworkExtension.framework.
 */
@available(macOS 13.0, *)
open class NEEthernetTunnelProvider : NEPacketTunnelProvider {
}

/**
 * @typedef NEOnDemandRuleAction
 * @abstract On Demand rule actions
 */
@available(macOS 10.11, *)
public enum NEOnDemandRuleAction : Int, @unchecked Sendable {

    /** @const NEOnDemandRuleActionConnect Start the VPN connection */
    case connect = 1

    /** @const NEOnDemandRuleActionDisconnect Do not start the VPN connection, and disconnect the VPN connection if it is not currently disconnected */
    case disconnect = 2

    /** @const NEOnDemandRuleActionEvaluateConnection Start the VPN after evaluating the destination host being accessed against the rule's connection rules */
    case evaluateConnection = 3

    /** @const NEOnDemandRuleActionIgnore Do not start the VPN connection, and leave the VPN connection in its current state */
    case ignore = 4
}

/**
 * @typedef NEOnDemandRuleInterfaceType
 * @abstract On Demand rule network interface types
 */
@available(macOS 10.11, *)
public enum NEOnDemandRuleInterfaceType : Int, @unchecked Sendable {

    /** @const NEOnDemandRuleInterfaceTypeAny */
    @available(macOS 10.11, *)
    case any = 0

    /** @const NEOnDemandRuleInterfaceTypeEthernet Wired Ethernet */
    @available(macOS 10.11, *)
    case ethernet = 1

    /** @const NEOnDemandRuleInterfaceTypeWiFi WiFi */
    @available(macOS 10.11, *)
    case wiFi = 2
}

/**
 * @interface NEOnDemandRule
 * @discussion The NEOnDemandRule class declares the programmatic interface for an object that defines an On Demand rule.
 *
 * NEOnDemandRule is an abstract base class from which other action-specific rule classes are derived.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEOnDemandRule : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property action
     * @discussion The rule's action
     */
    @available(macOS 10.11, *)
    open var action: NEOnDemandRuleAction { get }

    /**
     * @property DNSSearchDomainMatch
     * @discussion An array of NSString objects. If the current default search domain is equal to one of the strings in this array and all of the other conditions in the rule match, then the rule matches. If this property is nil (the default), then the current default search domain does not factor into the rule match.
     */
    @available(macOS 10.11, *)
    open var dnsSearchDomainMatch: [String]?

    /**
     * @property DNSServerAddressMatch
     * @discussion An array of DNS server IP addresses represented as NSString objects. If each of the current default DNS servers is equal to one of the strings in this array and all of the other conditions in the rule match, then the rule matches. If this property is nil (the default), then the default DNS servers do not factor into the rule match.
     */
    @available(macOS 10.11, *)
    open var dnsServerAddressMatch: [String]?

    /**
     * @property interfaceTypeMatch
     * @discussion The type of interface that this rule matches. If the current primary network interface is of this type and all of the other conditions in the rule match, then the rule matches. If this property is 0 (the default), then the current primary interface type does not factor into the rule match.
     */
    @available(macOS 10.11, *)
    open var interfaceTypeMatch: NEOnDemandRuleInterfaceType

    /**
     * @property SSIDMatch
     * @discussion An array of NSString objects. If the Service Set Identifier (SSID) of the current primary connected network matches one of the strings in this array and all of the other conditions in the rule match, then the rule matches. If this property is nil (the default), then the current primary connected network SSID does not factor into the rule match.
     */
    @available(macOS 10.11, *)
    open var ssidMatch: [String]?

    /**
     * @property probeURL
     * @discussion An HTTP or HTTPS URL. If a request sent to this URL results in a HTTP 200 OK response and all of the other conditions in the rule match, then then rule matches. If this property is nil (the default), then an HTTP request does not factor into the rule match.
     */
    @available(macOS 10.11, *)
    open var probeURL: URL?
}

/**
 * @interface NEOnDemandRuleConnect
 * @discussion The NEOnDemandRuleConnect class declares the programmatic interface for an object that defines an On Demand rule with the "Connect" action.
 *
 * When rules of this class match, the VPN connection is started whenever an application running on the system opens a network connection.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEOnDemandRuleConnect : NEOnDemandRule {
}

/**
 * @interface NEOnDemandRuleDisconnect
 * @discussion The NEOnDemandRuleDisconnect class declares the programmatic interface for an object that defines an On Demand rule with the "Disconnect" action.
 *
 * When rules of this class match, the VPN connection is not started, and the VPN connection is disconnected if it is not currently disconnected.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEOnDemandRuleDisconnect : NEOnDemandRule {
}

/**
 * @interface NEOnDemandRuleIgnore
 * @discussion The NEOnDemandRuleIgnore class declares the programmatic interface for an object that defines an On Demand rule with the "Ignore" action.
 *
 * When rules of this class match, the VPN connection is not started, and the current status of the VPN connection is left unchanged.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEOnDemandRuleIgnore : NEOnDemandRule {
}

/**
 * @interface NEOnDemandRuleEvaluateConnection
 * @discussion The NEOnDemandRuleEvaluateConnection class declares the programmatic interface for an object that defines an On Demand rule with the "Evaluate Connection" action.
 *
 * When rules of this class match, the properties of the network connection being established are matched against a set of connection rules. The action of the matched rule (if any) is used to determine whether or not the VPN will be started.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEOnDemandRuleEvaluateConnection : NEOnDemandRule {

    /**
     * @property connectionRules
     * @discussion An array of NEEvaluateConnectionRule objects. Each NEEvaluateConnectionRule object is evaluated in order against the properties of the network connection being established.
     */
    @available(macOS 10.11, *)
    open var connectionRules: [NEEvaluateConnectionRule]?
}

/**
 * @typedef NEEvaluateConnectionRuleAction
 * @abstract Evaluate Connection rule actions
 */
@available(macOS 10.11, *)
public enum NEEvaluateConnectionRuleAction : Int, @unchecked Sendable {

    /** @const NEEvaluateConnectionRuleActionConnectIfNeeded Start the VPN connection if the destination host is not accessible directly */
    case connectIfNeeded = 1

    /** @const NEEvaluateConnectionRuleActionNeverConnect Do not start the VPN connection */
    case neverConnect = 2
}

/**
 * @interface NEEvaluateConnectionRule
 * @discussion The NEEvaluateConnectionRule class declares the programmatic interface for an object that associates properties of network connections with an action.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEEvaluateConnectionRule : NSObject, NSSecureCoding, NSCopying {

    /**
     * @method initWithMatchDomains:andAction
     * @discussion Initialize an NEEvaluateConnectionRule instance with a list of destination host domains and an action
     */
    @available(macOS 10.11, *)
    public init(matchDomains domains: [String], andAction action: NEEvaluateConnectionRuleAction)

    /**
     * @property action
     * @discussion The action to take if the properties of the network connection being established match the rule.
     */
    @available(macOS 10.11, *)
    open var action: NEEvaluateConnectionRuleAction { get }

    /**
     * @property matchDomains
     * @discussion An array of NSString objects. If the host name of the destination of the network connection being established shares a suffix with one of the strings in this array, then the rule matches.
     */
    @available(macOS 10.11, *)
    open var matchDomains: [String] { get }

    /**
     * @property useDNSServers
     * @discussion An array of NSString objects. If the rule matches the connection being established and the action is NEEvaluateConnectionRuleActionConnectIfNeeded, the DNS servers specified in this array are used to resolve the host name of the destination while evaluating connectivity to the destination. If the resolution fails for any reason, the VPN is started.
     */
    @available(macOS 10.11, *)
    open var useDNSServers: [String]?

    /**
     * @property probeURL
     * @discussion An HTTP or HTTPS URL. If the rule matches the connection being established and the action is NEEvaluateConnectionRuleActionConnectIfNeeded and a request sent to this URL results in a response with an HTTP response code other than 200, then the VPN is started.
     */
    @available(macOS 10.11, *)
    open var probeURL: URL?
}

/**
 * @interface NEPacket
 * @discussion An NEPacket object represents the data, protocol family, and metadata associated with an IP packet.
 *    These packets are used to read and write on an NEPacketTunnelFlow.
 *
 * NEPacket is part of NetworkExtension.framework
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.12, *)
open class NEPacket : NSObject, NSCopying, NSSecureCoding {

    /**
     * @method initWithData:protocolFamily:
     * @discussion Initializes a new NEPacket object with data and protocol family.
     * @param data The content of the packet.
     * @param protocolFamily The protocol family of the packet (such as AF_INET or AF_INET6).
     */
    @available(macOS 10.12, *)
    public init(data: Data, protocolFamily: sa_family_t)

    /**
     * @property data
     * @discussion The data content of the packet.
     */
    @available(macOS 10.12, *)
    open var data: Data { get }

    /**
     * @property protocolFamily
     * @discussion The protocol family of the packet (such as AF_INET or AF_INET6).
     */
    @available(macOS 10.12, *)
    open var protocolFamily: sa_family_t { get }

    /**
     * @property direction
     * @discussion The direction of the packet.
     */
    @available(macOS 10.15, *)
    open var direction: NETrafficDirection { get }

    /**
     * @property metadata
     * @discussion Metadata about the source application and flow for this packet.
     *    This property will only be non-nil when the routing method for the NEPacketTunnelProvider
     *    is NETunnelProviderRoutingMethodSourceApplication.
     */
    @available(macOS 10.12, *)
    open var metadata: NEFlowMetaData? { get }
}

/**
 * @interface NEPacketTunnelFlow
 * @discussion The NEPacketTunnelFlow class declares the programmatic interface of an object that is used by NEPacketTunnelProvider implementations to tunnel IP packets.
 *
 * NEPacketTunnelFlow is part of NetworkExtension.framework
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEPacketTunnelFlow : NSObject {

    /**
     * @method readPacketsWithCompletionHandler:
     * @discussion Read available IP packets from the flow.
     * @param completionHandler A block that will be executed to handle the packets. This block takes an array of NSData objects and an array of NSNumber objects. The NSData and NSNumber in corresponding indicies in the array represent one packet. If after handling the packets the caller wants to read more packets then the caller must call this method again.
     */
    @available(macOS 10.11, *)
    open func readPackets(completionHandler: @escaping @Sendable ([Data], [NSNumber]) -> Void)

    /**
     * @method readPacketsWithCompletionHandler:
     * @discussion Read available IP packets from the flow.
     * @param completionHandler A block that will be executed to handle the packets. This block takes an array of NSData objects and an array of NSNumber objects. The NSData and NSNumber in corresponding indicies in the array represent one packet. If after handling the packets the caller wants to read more packets then the caller must call this method again.
     */
    @available(macOS 10.11, *)
    open func readPackets() async -> ([Data], [NSNumber])

    /**
     * @method writePackets:completionHandler:
     * @discussion Write multiple IP packets to the flow.
     * @param packets An array of NSData objects, each containing packet data to be written.
     * @param protocols An array of NSNumber objects. Each number contains the protocol of the packet in the corresponding index in the packets array.
     */
    @available(macOS 10.11, *)
    open func writePackets(_ packets: [Data], withProtocols protocols: [NSNumber]) -> Bool

    /**
     * @method readPacketObjectsWithCompletionHandler:
     * @discussion Read available IP packets from the flow.
     * @param completionHandler A block that will be executed to handle the packets. This block takes an array of NEPacket objects. If after handling the packets the caller wants to read more packets then the caller must call this method again.
     */
    @available(macOS 10.12, *)
    open func readPacketObjects(completionHandler: @escaping @Sendable ([NEPacket]) -> Void)

    /**
     * @method readPacketObjectsWithCompletionHandler:
     * @discussion Read available IP packets from the flow.
     * @param completionHandler A block that will be executed to handle the packets. This block takes an array of NEPacket objects. If after handling the packets the caller wants to read more packets then the caller must call this method again.
     */
    @available(macOS 10.12, *)
    open func readPacketObjects() async -> [NEPacket]

    /**
     * @method writePacketObjects:
     * @discussion Write multiple IP packets to the flow.
     * @param packets An array of NEPacket objects, each containing packet data and protocol family to be written.
     */
    @available(macOS 10.12, *)
    open func writePacketObjects(_ packets: [NEPacket]) -> Bool
}

/**
 * @interface NERelay
 * @discussion The NERelay class declares the programmatic interface of an object that
 *             manages the details of a relay's configuration, such as authentication and URL details.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 14.0, *)
open class NERelay : NSObject, NSCopying, NSSecureCoding {

    /**
     * @property HTTP3RelayURL
     * @discussion The URL of the relay accessible over HTTP/3.
     */
    open var http3RelayURL: URL?

    /**
     * @property HTTP2RelayURL
     * @discussion The URL of the relay accessible over HTTP/2.
     */
    open var http2RelayURL: URL?

    /**
     * @property dnsOverHTTPSURL
     * @discussion The URL of a DNS-over-HTTPS (DoH) resolver accessible via the relay.
     */
    open var dnsOverHTTPSURL: URL?

    /**
     * @property syntheticDNSAnswerIPv4Prefix
     * @discussion An IPv4 address prefix (such as "192.0.2.0/24") that will be used to synthesize
     *      DNS answers for apps that use `getaddrinfo()` to resolve domains included in `matchDomains`
     */
    open var syntheticDNSAnswerIPv4Prefix: String?

    /**
     * @property syntheticDNSAnswerIPv6Prefix
     * @discussion An IPv6 address prefix (such as "2001:DB8::/32") that will be used to synthesize
     *      DNS answers for apps that use `getaddrinfo()` to resolve domains included in `matchDomains`
     */
    open var syntheticDNSAnswerIPv6Prefix: String?

    /**
     * @property additionalHTTPHeaderFields
     * @discussion Additional HTTP header field names and values to be added to all relay requests.
     */
    open var additionalHTTPHeaderFields: [String : String]

    /**
     * @property rawPublicKeys
     * @discussion TLS 1.3 raw public keys to use to authenticate the relay servers.
     */
    open var rawPublicKeys: [Data]?

    /**
     * @property identityData
     * @discussion The PKCS12 data for the relay client authentication. The value is a NSData in PKCS12 format.
     */
    open var identityData: Data?

    /**
     * @property identityDataPassword
     * @discussion The password to be used to decrypt the PKCS12 identity data.
     */
    open var identityDataPassword: String?
}

/**
 * @typedef NERelayManagerError
 * @abstract NERelay Manager error codes
 */
@available(macOS 14.0, *)
public enum NERelayManagerError : Int, @unchecked Sendable {

    /** @const NERelayManagerErrorConfigurationInvalid The relay manager is invalid */
    case configurationInvalid = 1

    /** @const NERelayManagerErrorConfigurationDisabled The relay manager is not enabled. */
    case configurationDisabled = 2

    /** @const NERelayManagerErrorConfigurationStale The relay manager needs to be loaded. */
    case configurationStale = 3

    /** @const NERelayManagerErrorConfigurationCannotBeRemoved The relay manager cannot be removed. */
    case configurationCannotBeRemoved = 4
}

/** @const NERelayErrorDomain The NERelay error domain */
@available(macOS 14.0, *)
public let NERelayErrorDomain: String

/**
 * @typedef NERelayManagerClientError
 * @abstract NERelay Manager error codes detected by the client while trying to use this relay
 */
@available(macOS 15.0, *)
public enum NERelayManagerClientError : Int, @unchecked Sendable {

    /** @const NERelayManagerClientErrorNone The client did not have an error on the last connection */
    case none = 1

    /** @const NERelayManagerClientErrorDNSFailed DNS resolution of the relay server failed */
    case dnsFailed = 2

    /** @const NERelayManagerClientErrorServerUnreachable The relay server was unreachable */
    case serverUnreachable = 3

    /** @const NERelayManagerClientErrorServerDisconnected The relay server prematurely disconnected the connection  */
    case serverDisconnected = 4

    /** @const NERelayManagerClientErrorCertificateMissing The certificate needed to connect to the relay server could not be accessed or was not provided */
    case certificateMissing = 5

    /** @const NERelayManagerClientErrorCertificateInvalid The certificate needed to connect to the relay server was invalid. */
    case certificateInvalid = 6

    /** @const NERelayManagerClientErrorCertificateExpired The certificate needed to connect to the relay server was expired. */
    case certificateExpired = 7

    /** @const NERelayManagerClientErrorServerCertificateInvalid The relay server certificate was invalid. */
    case serverCertificateInvalid = 8

    /** @const NERelayManagerClientErrorServerCertificateExpired The relay server certificate was expired. */
    case serverCertificateExpired = 9

    /** @const NERelayManagerClientErrorOther The client detected an error that has not yet been enumerated */
    case other = 10
}

/** @const NERelayClientErrorDomain The NERelay error domain as detected by the client*/
@available(macOS 15.0, *)
public let NERelayClientErrorDomain: String

/**
 * @interface NERelayManager
 * @discussion The NERelayManager class declares the programmatic interface for an object that manages relay configurations.
 *
 * NERelayManager declares methods and properties for configuring and controlling relay settings on the system.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 14.0, *)
open class NERelayManager : NSObject {

    /**
     * @method sharedManager
     * @return The singleton NERelayManager object for the calling process.
     */
    open class func shared() -> NERelayManager

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current relay configuration from the caller's relay preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    open func loadFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method loadFromPreferencesWithCompletionHandler:
     * @discussion This function loads the current relay configuration from the caller's relay preferences.
     * @param completionHandler A block that will be called when the load operation is completed. The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    open func loadFromPreferences() async throws

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the relay configuration from the caller's relay preferences. If the relay is enabled, the relay becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    open func removeFromPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method removeFromPreferencesWithCompletionHandler:
     * @discussion This function removes the relay configuration from the caller's relay preferences. If the relay is enabled, the relay becomes disabled.
     * @param completionHandler A block that will be called when the remove operation is completed. The NSError passed to this block will be nil if the remove operation succeeded, non-nil otherwise.
     */
    open func removeFromPreferences() async throws

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the relay configuration in the caller's relay preferences. If the relay are enabled, they will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    open func saveToPreferences(completionHandler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method saveToPreferencesWithCompletionHandler:
     * @discussion This function saves the relay configuration in the caller's relay preferences. If the relay are enabled, they will become active.
     * @param completionHandler A block that will be called when the save operation is completed. The NSError passed to this block will be nil if the save operation succeeded, non-nil otherwise.
     */
    open func saveToPreferences() async throws

    /**
     * @method getLastClientErrors
     * @discussion This function will get errors that the client detected while using this relay configuration within the specified time period.  Errors will be from the NERelayClientErrorDomain and the NERelayManagerClientErrorNone value will be set for successful connections.
     * @param seconds A NSTimeInterval that specifies how many seconds to report errors for.  The maximum supported value is 24 hours and any larger values will be automatically reduced to 24 hours.
     * @param completionHandler A block that will be called when once the errors have been collected. The NSArray will contain a list of NERelayManagerClientError values detected within the last number of seconds as specified by the "seconds" parameter.  The values will be ordered from the error most recently detected to the oldest.  The error value of NERelayManagerClientErrorNone indicates the last successful use of the relay without error.  The NSArray will be empty if there are no values detected within the specified time period or nil if there was a problem in retrieving the errors.
     */
    @available(macOS 15.0, *)
    open func getLastClientErrors(_ seconds: TimeInterval, completionHandler: @escaping @Sendable ([any Error]?) -> Void)

    /**
     * @method getLastClientErrors
     * @discussion This function will get errors that the client detected while using this relay configuration within the specified time period.  Errors will be from the NERelayClientErrorDomain and the NERelayManagerClientErrorNone value will be set for successful connections.
     * @param seconds A NSTimeInterval that specifies how many seconds to report errors for.  The maximum supported value is 24 hours and any larger values will be automatically reduced to 24 hours.
     * @param completionHandler A block that will be called when once the errors have been collected. The NSArray will contain a list of NERelayManagerClientError values detected within the last number of seconds as specified by the "seconds" parameter.  The values will be ordered from the error most recently detected to the oldest.  The error value of NERelayManagerClientErrorNone indicates the last successful use of the relay without error.  The NSArray will be empty if there are no values detected within the specified time period or nil if there was a problem in retrieving the errors.
     */
    @available(macOS 15.0, *)
    open func lastClientErrors(_ seconds: TimeInterval) async -> [any Error]?

    /**
     * @property localizedDescription
     * @discussion A string containing a description of the relay.
     */
    open var localizedDescription: String?

    /**
     * @property enabled
     * @discussion Toggles the enabled status of the relay. */
    open var isEnabled: Bool

    /**
     * @property uiToggleEnabled
     * @discussion Determines if the user will have the ability to enable and disable the relay */
    open var isUIToggleEnabled: Bool

    /**
     * @property allowDNSFailover
     * @discussion Determines if DNS queries that fail over relay can fallback to default DNS */
    @available(macOS 26.0, *)
    open var isDNSFailoverAllowed: Bool

    /**
     * @property relays
     * @discussion An array of relay configurations describing one or more relay hops.
     */
    open var relays: [NERelay]?

    /**
     * @property matchDomains
     * @discussion An array of strings containing domain names. If this property is non-nil, the relay will be used to access hosts within the specified domains. If this and the match FQDNs property is nil, the relay will be used for all domains.
     */
    open var matchDomains: [String]?

    /**
     * @property matchFQDNs
     * @discussion An array of strings containing Fully Qualified Domain Names (FQDNs). If this property is non-nil, the relay will be used to access the specified hosts.  If this and the matchDomains property is nil, the relay will be used for all domains.
     */
    open var matchFQDNs: [String]?

    /**
     * @property excludedDomains
     * @discussion An array of strings containing domain names. If the destination host name of a connection shares a suffix with one of these strings then the relay will not be used.
     */
    open var excludedDomains: [String]?

    /**
     * @property excludedFQDNs
     * @discussion An array of strings containing Fully Qualified Domain Names (FQDNs). If the destination host matches one of these strings then the relay will not be used.  An excluded FQDN takes priority over the matchDomain property.  This means the relay will not be used if the hostname matches an FQDN in this array even if the matchDomains contains a domain that would have been considered a match.
     */
    open var excludedFQDNs: [String]?

    /**
     * @property onDemandRules
     * @discussion An array of NEOnDemandRule objects. If nil, the associated relay will always apply. If non-nil, the array describes the networks on which the relay should be used or not.
     */
    open var onDemandRules: [NEOnDemandRule]?

    /**
     * @method loadAllManagersFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the NERelay configurations created by the calling app that have previously been saved to disk and returns them as NERelayManager objects.
     * @param completionHandler A block that takes an array NERelayManager objects. The array passed to the block may be empty if no NERelay configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    open class func loadAllManagersFromPreferences(completionHandler: @escaping @Sendable ([NERelayManager], (any Error)?) -> Void)

    /**
     * @method loadAllManagersFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the NERelay configurations created by the calling app that have previously been saved to disk and returns them as NERelayManager objects.
     * @param completionHandler A block that takes an array NERelayManager objects. The array passed to the block may be empty if no NERelay configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    open class func loadAllManagersFromPreferences() async throws -> [NERelayManager]
}

/**
 * @interface NETransparentProxyManager
 * @discussion The NETransparentProxyManager class declares the programmatic interface for an object that is used to configure and control transparent proxies provided by NEAppProxyProviders.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.15, *)
open class NETransparentProxyManager : NEVPNManager {

    /**
     * @method loadAllFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the transparent proxy configurations associated with the calling app that have previously been saved to disk and returns them as NETransparentProxyManager objects.
     * @param completionHandler A block that takes an array NETransparentProxyManager objects. The array passed to the block may be empty if no transparent proxy configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open class func loadAllFromPreferences(completionHandler: @escaping @Sendable ([NETransparentProxyManager]?, (any Error)?) -> Void)

    /**
     * @method loadAllFromPreferencesWithCompletionHandler:
     * @discussion This function asynchronously reads all of the transparent proxy configurations associated with the calling app that have previously been saved to disk and returns them as NETransparentProxyManager objects.
     * @param completionHandler A block that takes an array NETransparentProxyManager objects. The array passed to the block may be empty if no transparent proxy configurations were successfully read from the disk.  The NSError passed to this block will be nil if the load operation succeeded, non-nil otherwise.
     */
    @available(macOS 10.15, *)
    open class func loadAllFromPreferences() async throws -> [NETransparentProxyManager]
}

/**
 * @interface NETransparentProxyNetworkSettings
 * @discussion The NETransparentProxyNetworkSettings class declares the programmatic interface for an object that contains network settings.
 *
 * NETransparentProxyNetworkSettings is used by NEAppProxyProviders to communicate the desired network settings for the proxy to the framework. The framework takes care of applying the contained settings to the system.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.15, *)
open class NETransparentProxyNetworkSettings : NETunnelNetworkSettings {

    /**
     * @property includedNetworkRules
     * @discussion An array of NENetworkRule objects that collectively specify the traffic that will be routed through the transparent proxy. The following restrictions
     *    apply to each NENetworkRule in this list:
     *    Restrictions for rules with an address endpoint:
     *        If the port string of the endpoint is "0" or is the empty string, then the address of the endpoint must be a non-wildcard address (i.e. "0.0.0.0" or "::").
     *        If the address is a wildcard address (i.e. "0.0.0.0" or "::"), then the port string of the endpoint must be non-empty and must not be "0".
     *        A port string of "53" is not allowed. Destination Domain-based rules must be used to match DNS traffic.
     *        The matchLocalNetwork property must be nil.
     *        The matchDirection property must be NETrafficDirectionOutbound.
     */
    @available(macOS 10.15, *)
    open var includedNetworkRules: [NENetworkRule]?

    /**
     * @property excludedNetworkRules
     * @discussion An array of NENetworkRule objects that collectively specify the traffic that will not be routed through the transparent proxy. The following restrictions
     *    apply to each NENetworkRule in this list:
     *    Restrictions for rules with an address endpoint:
     *        If the port string of the endpoint is "0" or is the empty string, then the address of the endpoint must be a non-wildcard address (i.e. "0.0.0.0" or "::").
     *        If the address is a wildcard address (i.e. "0.0.0.0" or "::"), then the port string of the endpoint must be non-empty and must not be "0".
     *        A port string of "53" is not allowed. Destination Domain-based rules must be used to match DNS traffic.
     *        The matchLocalNetwork property must be nil.
     *        The matchDirection property must be NETrafficDirectionOutbound.
     */
    @available(macOS 10.15, *)
    open var excludedNetworkRules: [NENetworkRule]?
}

/**
 * @interface NETransparentProxyProvider
 * @discussion The NETransparentProxyProvider class declares the programmatic interface for an object that implements the client side of a custom transparent network proxy solution.
 *     The NETransparentProxyProvider class has the following behavior differences from its super class NEAppProxyProvider:
 *         - Returning NO from handleNewFlow: and handleNewUDPFlow:initialRemoteEndpoint: causes the flow to proceed to communicate directly with the flow's ultimate destination, instead of closing the flow with a "Connection Refused" error.
 *         - NEDNSSettings and NEProxySettings specified within NETransparentProxyNetworkSettings are ignored. Flows that match the includedNetworkRules within NETransparentProxyNetworkSettings will use the same DNS and proxy settings that other flows on the system are currently using.
 *         - Flows that are created using a "connect by name" API (such as Network.framework or NSURLSession) that match the includedNetworkRules will not bypass DNS resolution.
 *
 * NETransparentProxyProvider is part of NetworkExtension.framework
 */
@available(macOS 11.0, *)
open class NETransparentProxyProvider : NEAppProxyProvider {
}

/**
 * @typedef NEVPNStatus
 * @abstract VPN status codes
 */
@available(macOS 10.11, *)
public enum NEVPNStatus : Int, @unchecked Sendable {

    /** @const NEVPNStatusInvalid The VPN is not configured. */
    case invalid = 0

    /** @const NEVPNStatusDisconnected The VPN is disconnected. */
    case disconnected = 1

    /** @const NEVPNStatusConnecting The VPN is connecting. */
    case connecting = 2

    /** @const NEVPNStatusConnected The VPN is connected. */
    case connected = 3

    /** @const NEVPNStatusReasserting The VPN is reconnecting following loss of underlying network connectivity. */
    case reasserting = 4

    /** @const NEVPNStatusDisconnecting The VPN is disconnecting. */
    case disconnecting = 5
}

/** @const NEVPNConnectionStartOptionUsername Specify this key in the options dictionary passed to startVPNTunnelWithOptions:returningError: to override the username saved in the configuration. The value is a string */
@available(macOS 10.11, *)
public let NEVPNConnectionStartOptionUsername: String

/** @const NEVPNConnectionStartOptionPassword Specify this key in the options dictionary passed to startVPNTunnelWithOptions:returningError: to override the password saved in the configuration. The value is a string */
@available(macOS 10.11, *)
public let NEVPNConnectionStartOptionPassword: String

/**
 * @typedef NEVPNConnectionError
 * @abstract VPN error codes
 */
@available(macOS 13.0, *)
public enum NEVPNConnectionError : Int, @unchecked Sendable {

    /** @const NEVPNConnectionErrorOverslept The VPN connection was terminated because the system slept for an extended period of time. */
    case overslept = 1

    /** @const NEVPNConnectionErrorNoNetworkAvailable The VPN connection could not be established because the system is not connected to a network. */
    case noNetworkAvailable = 2

    /** @const NEVPNConnectionErrorUnrecoverableNetworkChange The VPN connection was terminated because the network conditions changed in such a
         * way that the VPN connection could not be maintained. */
    case unrecoverableNetworkChange = 3

    /** @const NEVPNConnectionErrorConfigurationFailed The VPN connection could not be established because the configuration is invalid. */
    case configurationFailed = 4

    /** @const NEVPNConnectionErrorServerAddressResolutionFailed The address of the VPN server could not be determined. */
    case serverAddressResolutionFailed = 5

    /** @const NEVPNConnectionErrorServerNotResponding Network communication with the VPN server has failed. */
    case serverNotResponding = 6

    /** @const NEVPNConnectionErrorServerDead The VPN server is no longer functioning. */
    case serverDead = 7

    /** @const NEVPNConnectionErrorAuthenticationFailed The user credentials were rejected by the VPN server. */
    case authenticationFailed = 8

    /** @const NEVPNConnectionErrorClientCertificateInvalid The client certificate is invalid. */
    case clientCertificateInvalid = 9

    /** @const NEVPNConnectionErrorClientCertificateNotYetValid The client certificate will not be valid until some future point in time. */
    case clientCertificateNotYetValid = 10

    /** @const NEVPNConnectionErrorClientCertificateExpired The validity period of the client certificate has passed. */
    case clientCertificateExpired = 11

    /** @const NEVPNConnectionErrorPluginFailed The VPN plugin died unexpectedly. */
    case pluginFailed = 12

    /** @const NEVPNConnectionErrorConfigurationNotFound The VPN configuration could not be found . */
    case configurationNotFound = 13

    /** @const NEVPNConnectionErrorPluginDisabled The VPN plugin could not be found or needed to be updated. */
    case pluginDisabled = 14

    /** @const NEVPNConnectionErrorNegotiationFailed The VPN protocol negotiation failed. */
    case negotiationFailed = 15

    /** @const NEVPNConnectionErrorServerDisconnected The VPN server terminated the connection. */
    case serverDisconnected = 16

    /** @const NEVPNConnectionErrorServerCertificateInvalid The server certificate is invalid. */
    case serverCertificateInvalid = 17

    /** @const NEVPNConnectionErrorServerCertificateNotYetValid The server certificate will not be valid until some future point in time. */
    case serverCertificateNotYetValid = 18

    /** @const NEVPNConnectionErrorServerCertificateExpired The validity period of the server certificate has passed. */
    case serverCertificateExpired = 19
}

/** @const NEVPNConnectionErrorDomain The VPN connection error domain */
@available(macOS 13.0, *)
public let NEVPNConnectionErrorDomain: String

/**
 * @interface NEVPNConnection
 * @discussion The NEVPNConnection class declares the programmatic interface for an object that manages VPN connections.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEVPNConnection : NSObject {

    /**
     * @method startVPNTunnelAndReturnError:
     * @discussion This function is used to start the VPN tunnel using the current VPN configuration. The VPN tunnel connection process is started and this function returns immediately.
     * @param error If the VPN tunnel was started successfully, this parameter is set to nil. Otherwise this parameter is set to the error that occurred. Possible errors include:
     *    1. NEVPNErrorConfigurationInvalid
     *    2. NEVPNErrorConfigurationDisabled
     * @return YES if the VPN tunnel was started successfully, NO if an error occurred.
     */
    @available(macOS 10.11, *)
    open func startVPNTunnel() throws

    /**
     * @method startVPNTunnelWithOptions:andReturnError:
     * @discussion This function is used to start the VPN tunnel using the current VPN configuration. The VPN tunnel connection process is started and this function returns immediately.
     * @param options A dictionary that will be passed to the tunnel provider during the process of starting the tunnel.
     *    If not nil, 'options' is an NSDictionary may contain the following keys
     *        NEVPNConnectionStartOptionUsername
     *        NEVPNConnectionStartOptionPassword
     * @param error If the VPN tunnel was started successfully, this parameter is set to nil. Otherwise this parameter is set to the error that occurred. Possible errors include:
     *    1. NEVPNErrorConfigurationInvalid
     *    2. NEVPNErrorConfigurationDisabled
     * @return YES if the VPN tunnel was started successfully, NO if an error occurred.
     */
    @available(macOS 10.11, *)
    open func startVPNTunnel(options: [String : NSObject]? = nil) throws

    /**
     * @method stopVPNTunnel:
     * @discussion This function is used to stop the VPN tunnel. The VPN tunnel disconnect process is started and this function returns immediately.
     */
    @available(macOS 10.11, *)
    open func stopVPNTunnel()

    /**
     * @method fetchLastDisconnectErrorWithCompletionHandler:
     * @discussion Retrive the most recent error that caused the VPN to disconnect. If the error was generated by the VPN system (including the IPsec client) then the error will be in the NEVPNConnectionErrorDomain error domain. If the error was generated by a tunnel provider app extension then the error will be the NSError that the provider passed when disconnecting the tunnel.
     * @param handler A block which takes an optional NSError that will be called when the error is obtained.
     */
    @available(macOS 13.0, *)
    open func fetchLastDisconnectError(completionHandler handler: @escaping @Sendable ((any Error)?) -> Void)

    /**
     * @method fetchLastDisconnectErrorWithCompletionHandler:
     * @discussion Retrive the most recent error that caused the VPN to disconnect. If the error was generated by the VPN system (including the IPsec client) then the error will be in the NEVPNConnectionErrorDomain error domain. If the error was generated by a tunnel provider app extension then the error will be the NSError that the provider passed when disconnecting the tunnel.
     * @param handler A block which takes an optional NSError that will be called when the error is obtained.
     */
    @available(macOS 13.0, *)
    open func fetchLastDisconnectError() async throws

    /**
     * @property status
     * @discussion The current status of the VPN.
     */
    @available(macOS 10.11, *)
    open var status: NEVPNStatus { get }

    /**
     * @property connectedDate
     * @discussion The date and time when the connection status changed to NEVPNStatusConnected. This property is nil if the connection is not fully established.
     */
    @available(macOS 10.11, *)
    open var connectedDate: Date? { get }

    /**
     * @property manager
     * @discussion The NEVPNManager associated with this NEVPNConnection.
     */
    @available(macOS 10.12, *)
    open var manager: NEVPNManager { get }
}

/**
 * @file NETunnelProviderSession.h
 * @discussion This file declares the NETunnelProviderSession API. The NETunnelProviderSession API is used to control network tunnel services provided by NETunnelProvider implementations.
 *
 * This API is part of NetworkExtension.framework.
 */
@available(macOS 10.11, *)
open class NETunnelProviderSession : NEVPNConnection {

    /**
     * @method startTunnelWithOptions:andReturnError:
     * @discussion This function is used to start the tunnel using the configuration associated with this connection object. The tunnel connection process is started and this function returns immediately.
     * @param options A dictionary that will be passed as-is to the tunnel provider during the process of starting the tunnel.
     * @param error If the tunnel was started successfully, this parameter is set to nil. Otherwise this parameter is set to the error that occurred. Possible errors include:
     *    1. NEVPNErrorConfigurationInvalid
     *    2. NEVPNErrorConfigurationDisabled
     * @return YES if the tunnel was started successfully, NO if an error occurred.
     */
    @available(macOS 10.11, *)
    open func startTunnel(options: [String : Any]? = nil) throws

    /**
     * @method stopTunnel
     * @discussion This function is used to stop the tunnel. The tunnel disconnect process is started and this function returns immediately.
     */
    @available(macOS 10.11, *)
    open func stopTunnel()

    /**
     * @method sendProviderMessage:responseHandler:
     * @discussion This function sends a message to the NETunnelProvider and provides a way to receive a response.
     * @param messageData An NSData object containing the message to be sent.
     * @param error If the message was sent successfully, this parameter is set to nil. Otherwise this parameter is set to the error that occurred. Possible errors include:
     *    1. NEVPNErrorConfigurationInvalid
     *    2. NEVPNErrorConfigurationDisabled
     * @param responseHandler A block that handles the response. Can be set to nil if no response is expected.
     * @return YES if the message was sent successfully, NO if an error occurred.
     */
    @available(macOS 10.11, *)
    open func sendProviderMessage(_ messageData: Data, responseHandler: ((Data?) -> Void)? = nil) throws
}

/**
 * @interface NETunnelProviderProtocol
 * @discussion The NETunnelProviderProtocol class declares the programmatic interface for an object that contains NETunnelProvider-specific configuration settings.
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NETunnelProviderProtocol : NEVPNProtocol {

    /**
     * @property providerConfiguration
     * @discussion A dictionary containing NETunnelProvider vendor-specific configuration parameters. This dictionary is passed as-is to NETunnelProviders when a tunnel is started.
     */
    @available(macOS 10.11, *)
    open var providerConfiguration: [String : Any]?

    /**
     * @property providerBundleIdentifier
     * @discussion A string containing the bundle identifier of the NETunnelProvider to be used by this configuration.
     */
    @available(macOS 10.11, *)
    open var providerBundleIdentifier: String?
}

/**
 * @typedef NEVPNIKEAuthenticationMethod
 * @abstract Internet Key Exchange (IKE) authentication methods used to authenticate with the IPSec server.
 */
@available(macOS 10.11, *)
public enum NEVPNIKEAuthenticationMethod : Int, @unchecked Sendable {

    /** @const NEVPNIKEAuthenticationMethodNone Do not authenticate with the IPSec server */
    case none = 0

    /** @const NEVPNIKEAuthenticationMethodCertificate Use a certificate and private key as the authentication credential */
    case certificate = 1

    /** @const NEVPNIKEAuthenticationMethodSharedSecret Use a shared secret as the authentication credential */
    case sharedSecret = 2
}

/**
 * @interface NEVPNProtocolIPSec
 * @discussion The NEVPNProtocolIPSec class declares the programmatic interface of an object that manages the IPSec-specific portion of a VPN configuration.
 *
 * Instances of this class use IKE version 1 for key negotiation.
 */
@available(macOS 10.11, *)
open class NEVPNProtocolIPSec : NEVPNProtocol {

    /**
     * @property authenticationMethod
     * @discussion The method used to authenticate with the IPSec server. Note that if this property is set to NEVPNIKEAuthenticationMethodNone, extended authentication will still be negotiated if useExtendedAuthentication is set to YES.
     */
    @available(macOS 10.11, *)
    open var authenticationMethod: NEVPNIKEAuthenticationMethod

    /**
     * @property useExtendedAuthentication
     * @discussion A flag indicating if extended authentication will be negotiated. This authentication is in addition to the IKE authentication used to authenticate the endpoints of the IKE session.
     *   For IKE version 1, when this flag is set X-Auth authentication will be negotiated as part of the IKE session, using the username and password properties as the credential.
     *   For IKE version 2, when this flag is set EAP authentication will be negotiated as part of the IKE session, using the username, password, and/or identity properties as the credential depending on which EAP method the server requires.
     */
    @available(macOS 10.11, *)
    open var useExtendedAuthentication: Bool

    /**
     * @property sharedSecretReference
     * @discussion A persistent reference to a keychain item of class kSecClassGenericPassword containing the IKE shared secret.
     */
    @available(macOS 10.11, *)
    open var sharedSecretReference: Data?

    /**
     * @property localIdentifier
     * @discussion A string identifying the local IPSec endpoint for authentication purposes.
     */
    @available(macOS 10.11, *)
    open var localIdentifier: String?

    /**
     * @property remoteIdentifier
     * @discussion A string identifying the remote IPSec endpoint for authentication purposes.
     */
    @available(macOS 10.11, *)
    open var remoteIdentifier: String?
}

/**
 * @typedef NEVPNIKEv2EncryptionAlgorithm
 * @abstract IKEv2 Encryption Algorithms
 */
@available(macOS 10.11, *)
public enum NEVPNIKEv2EncryptionAlgorithm : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2EncryptionAlgorithmDES Data Encryption Standard (DES) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "DES is not supported")
    case algorithmDES = 1

    /** @const NEVPNIKEv2EncryptionAlgorithm3DES Triple Data Encryption Algorithm (aka 3DES) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "3DES is not supported")
    case algorithm3DES = 2

    /** @const NEVPNIKEv2EncryptionAlgorithmAES128 Advanced Encryption Standard 128 bit (AES128) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, message: "Use an encryption algorithm with 256-bit keys instead")
    case algorithmAES128 = 3

    /** @const NEVPNIKEv2EncryptionAlgorithmAES256 Advanced Encryption Standard 256 bit (AES256) */
    case algorithmAES256 = 4

    /** @const NEVPNIKEv2EncryptionAlgorithmAES128GCM Advanced Encryption Standard 128 bit (AES128GCM) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, message: "Use an encryption algorithm with 256-bit keys instead")
    case algorithmAES128GCM = 5

    /** @const NEVPNIKEv2EncryptionAlgorithmAES256GCM Advanced Encryption Standard 256 bit (AES256GCM) */
    @available(macOS 10.11, *)
    case algorithmAES256GCM = 6

    /** @const NEVPNIKEv2EncryptionAlgorithmChaCha20Poly1305 ChaCha20 and Poly1305 (ChaCha20Poly1305) */
    @available(macOS 10.15, *)
    case algorithmChaCha20Poly1305 = 7
}

/**
 * @typedef NEVPNIKEv2IntegrityAlgorithm
 * @abstract IKEv2 Integrity Algorithms
 */
@available(macOS 10.11, *)
public enum NEVPNIKEv2IntegrityAlgorithm : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2IntegrityAlgorithmSHA96 SHA-1 96 bit */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "SHA-1 is not supported")
    case SHA96 = 1

    /** @const NEVPNIKEv2IntegrityAlgorithmSHA160 SHA-1 160 bit */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "SHA-1 is not supported")
    case SHA160 = 2

    /** @const NEVPNIKEv2IntegrityAlgorithmSHA256 SHA-2 256 bit */
    case SHA256 = 3

    /** @const NEVPNIKEv2IntegrityAlgorithmSHA384 SHA-2 384 bit */
    case SHA384 = 4

    /** @const NEVPNIKEv2IntegrityAlgorithmSHA512 SHA-2 512 bit */
    case SHA512 = 5
}

/**
 * @typedef NEVPNIKEv2DeadPeerDetectionRate
 * @abstract IKEv2 Dead Peer Detection Rates
 */
@available(macOS 10.11, *)
public enum NEVPNIKEv2DeadPeerDetectionRate : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2DeadPeerDetectionRateNone Do not perform dead peer detection */
    case none = 0

    /** @const NEVPNIKEv2DeadPeerDetectionRateLow Run dead peer detection once every 30 minutes. If the peer does not respond, retry 5 times at 1 second intervals before declaring the peer dead */
    case low = 1

    /** @const NEVPNIKEv2DeadPeerDetectionRateMedium Run dead peer detection once every 10 minutes. If the peer does not respond, retry 5 times at 1 second intervals before declaring the peer dead */
    case medium = 2

    /** @const NEVPNIKEv2DeadPeerDetectionRateHigh Run dead peer detection once every 1 minute. If the peer does not respond, retry 5 times at 1 second intervals before declaring the peer dead */
    case high = 3
}

/**
 * @typedef NEVPNIKEv2DiffieHellmanGroup
 * @abstract IKEv2 Diffie Hellman groups
 */
@available(macOS 10.11, *)
public enum NEVPNIKEv2DiffieHellmanGroup : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2DiffieHellmanGroupInvalid Diffie Hellman group 0 is not a valid DH group*/
    case groupInvalid = 0

    /** @const NEVPNIKEv2DiffieHellmanGroup1 Diffie Hellman group 1 (768-bit MODP) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "Diffie Hellman groups less than 14 are not supported")
    case group1 = 1

    /** @const NEVPNIKEv2DiffieHellmanGroup2 Diffie Hellman group 2 (1024-bit MODP) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "Diffie Hellman groups less than 14 are not supported")
    case group2 = 2

    /** @const NEVPNIKEv2DiffieHellmanGroup5 Diffie Hellman group 5 (1536-bit MODP) */
    @available(macOS, introduced: 10.11, deprecated: 14.0, obsoleted: 26.0, message: "Diffie Hellman groups less than 14 are not supported")
    case group5 = 5

    /** @const NEVPNIKEv2DiffieHellmanGroup14 Diffie Hellman group 14 (2048-bit MODP) */
    case group14 = 14

    /** @const NEVPNIKEv2DiffieHellmanGroup15 Diffie Hellman group 15 (3072-bit MODP) */
    case group15 = 15

    /** @const NEVPNIKEv2DiffieHellmanGroup16 Diffie Hellman group 16 (4096-bit MODP) */
    case group16 = 16

    /** @const NEVPNIKEv2DiffieHellmanGroup17 Diffie Hellman group 17 (6144-bit MODP) */
    case group17 = 17

    /** @const NEVPNIKEv2DiffieHellmanGroup18 Diffie Hellman group 18 (8192-bit MODP) */
    case group18 = 18

    /** @const NEVPNIKEv2DiffieHellmanGroup19 Diffie Hellman group 19 (256-bit random ECP) */
    case group19 = 19

    /** @const NEVPNIKEv2DiffieHellmanGroup20 Diffie Hellman group 20 (384-bit random ECP) */
    case group20 = 20

    /** @const NEVPNIKEv2DiffieHellmanGroup21 Diffie Hellman group 21 (521-bit random ECP) */
    case group21 = 21

    /** @const NEVPNIKEv2DiffieHellmanGroup31 Diffie Hellman group 31 (Curve25519) */
    @available(macOS 10.15, *)
    case group31 = 31

    /** @const NEVPNIKEv2DiffieHellmanGroup32 Diffie Hellman group 32 (Curve448) */
    @available(macOS 14.0, *)
    case group32 = 32
}

/**
 * @typedef NEVPNIKEv2PostQuantumKeyExchangeMethod
 * @abstract IKEv2 post-quantum key exchange methods
 */
@available(macOS 26.0, *)
public enum NEVPNIKEv2PostQuantumKeyExchangeMethod : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2PostQuantumKeyExchangeMethodNone Do not perform a post-quantum key exchange */
    case methodNone = 0

    /** @const NEVPNIKEv2PostQuantumKeyExchangeMethod36 Post-Quantum Key Exchange method 36 (ML-KEM-768) */
    case method36 = 36

    /** @const NEVPNIKEv2PostQuantumKeyExchangeMethod37 Post-Quantum Key Exchange method 37 (ML-KEM-1024) */
    case method37 = 37
}

/**
 * @typedef NEVPNIKEv2CertificateType
 * @abstract IKEv2 Certificate types
 */
@available(macOS 10.11, *)
public enum NEVPNIKEv2CertificateType : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2CertificateType RSA */
    case RSA = 1

    /** @const NEVPNIKEv2CertificateTypeECDSA256 ECDSA with p-256 curve */
    case ECDSA256 = 2

    /** @const NEVPNIKEv2CertificateTypeECDSA384 ECDSA with p-384 curve */
    case ECDSA384 = 3

    /** @const NEVPNIKEv2CertificateTypeECDSA521 ECDSA with p-521 curve */
    case ECDSA521 = 4

    /** @const NEVPNIKEv2CertificateTypeEd25519 EdDSA with Edwards Curve25519 */
    @available(macOS 10.15, *)
    case ed25519 = 5

    /** @const NEVPNIKEv2CertificateTypeRSAPSS RSA-PSS */
    @available(macOS 14.0, *)
    case RSAPSS = 6
}

/**
 * @typedef NEVPNIKEv2TLSVersion
 * @abstract TLS Versions for use in EAP-TLS
 */
@available(macOS 10.13, *)
public enum NEVPNIKEv2TLSVersion : Int, @unchecked Sendable {

    /** @const NEVPNIKEv2TLSVersionDefault Use the default TLS configuration */
    case versionDefault = 0

    /** @const NEVPNIKEv2TLSVersion1_0 TLS 1.0 */
    case version1_0 = 1

    /** @const NEVPNIKEv2TLSVersion1_0 TLS 1.1 */
    case version1_1 = 2

    /** @const NEVPNIKEv2TLSVersion1_0 TLS 1.2 */
    case version1_2 = 3
}

/**
 * @class NEVPNIKEv2SecurityAssociationParameters
 * @discussion The NEVPNIKEv2SecurityAssociationParameters class declares the programmatic interface of an object that manages parameters for an IPSec Security Association
 *
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEVPNIKEv2SecurityAssociationParameters : NSObject, NSSecureCoding, NSCopying {

    /**
     * @property encryptionAlgorithm
     * @discussion The algorithm used by the Security Association to encrypt and decrypt data. On macOS and iOS, the default is NEVPNIKEv2EncryptionAlgorithmAES256 starting in macOS 11 and iOS 14.
     * Prior to that the default was NEVPNIKEv2EncryptionAlgorithm3DES. On tvOS, the default is NEVPNIKEv2EncryptionAlgorithmAES256GCM.
     */
    @available(macOS 10.11, *)
    open var encryptionAlgorithm: NEVPNIKEv2EncryptionAlgorithm

    /**
     * @property integrityAlgorithm
     * @discussion The algorithm used by the Security Association to verify the integrity of data.  The IKE psedo-random function algorithm will be inferred based on the integrity algorithm.
     * Default is NEVPNIKEv2IntegrityAlgorithmSHA256 starting in macOS 11, iOS 14, and tvOS 17.  Prior to that the default was NEVPNIKEv2IntegrityAlgorithmSHA96.
     */
    @available(macOS 10.11, *)
    open var integrityAlgorithm: NEVPNIKEv2IntegrityAlgorithm

    /**
     * @property diffieHellmanGroup
     * @discussion The Diffie Hellman group used by the Security Association. Default is NEVPNIKEv2DiffieHellmanGroup14 starting in macOS 11, iOS 14, and tvOS 17. Prior to that the default was NEVPNIKEv2DiffieHellmanGroup2.
     */
    @available(macOS 10.11, *)
    open var diffieHellmanGroup: NEVPNIKEv2DiffieHellmanGroup

    /**
     * @property lifetimeMinutes
     * @discussion The life time of the Security Association, in minutes. Default is 60 for IKE Security Associations, and 30 for Child Security Associations. Before the lifetime is reached, IKEv2 will attempt to rekey the Security Association to maintain the connection.
     */
    @available(macOS 10.11, *)
    open var lifetimeMinutes: Int32
}

@available(macOS 26.0, iOS 26.0, tvOS 26.0, *)
@available(watchOS, unavailable)
extension NEVPNIKEv2SecurityAssociationParameters {

    /// The post-quantum key exchange method(s) used by the Security Association, if any.
    ///
    /// Up to 7 methods may be specified, mapping to ADDKE1 - ADDKE7 from RFC 9370.
    public var postQuantumKeyExchangeMethods: [NEVPNIKEv2PostQuantumKeyExchangeMethod]
}

/**
 * @interface NEVPNIKEv2PPKConfiguration
 * @discussion The NEVPNIKEv2PPKConfiguration class declares the programmatic interface of an object that manages parameters for a Post-quantum Pre-shared Key (PPK)
 *
 * Instances of this class conform to RFC 8784.
 * Instances of this class are thread safe.
 */
@available(macOS 15.0, *)
open class NEVPNIKEv2PPKConfiguration : NSObject, NSCopying {

    /**
     * @method initWithIdentifier:keychainReference:
     * @discussion Initialize a newly-allocated NEVPNIKEv2PPKConfiguration object.
     * @param identifier The identifier for the PPK.
     * @param keychainReference A persistent reference to a keychain item of class kSecClassGenericPassword containing the PPK.
     */
    public init(identifier: String, keychainReference: Data)

    /**
     * @property identifier
     * @discussion The identifer for the PPK.
     */
    open var identifier: String { get }

    /**
     * @property keychainReference
     * @discussion A persistent reference to a keychain item of class kSecClassGenericPassword containing the PPK.
     */
    open var keychainReference: Data { get }

    /**
     * @property isMandatory
     * @discussion Boolean indicating whether use of the PPK is mandatory or not. Default is YES.
     */
    open var isMandatory: Bool
}

/**
 * @interface NEVPNProtocolIKEv2
 * @discussion The NEVPNProtocolIKEv2 class declares the programmatic interface of an object that manages the IKEv2-specific portion of a VPN configuration.
 *
 * Instances of this class use IKE version 2 for key negotiation.
 * Instances of this class are thread safe.
 */
@available(macOS 10.11, *)
open class NEVPNProtocolIKEv2 : NEVPNProtocolIPSec {

    /**
     * @property deadPeerDetectionRate
     * @discussion How frequently the IKEv2 client will run the dead peer detection algorithm.  Default is NEVPNIKEv2DeadPeerDetectionRateMedium.
     */
    @available(macOS 10.11, *)
    open var deadPeerDetectionRate: NEVPNIKEv2DeadPeerDetectionRate

    /**
     * @property serverCertificateIssuerCommonName
     * @discussion A string containing the Subject Common Name field of the Certificate Authority certificate that issued the IKEv2 server's certificate.
     */
    @available(macOS 10.11, *)
    open var serverCertificateIssuerCommonName: String?

    /**
     * @property serverCertificateCommonName
     * @discussion A string containing the value to verify in the IKEv2 server certificate's Subject Common Name field.
     */
    @available(macOS 10.11, *)
    open var serverCertificateCommonName: String?

    /**
     * @property certificateType
     * @discussion contains the type of certificate if an certificate is configured.  Default is RSA.
     */
    @available(macOS 10.11, *)
    open var certificateType: NEVPNIKEv2CertificateType

    /**
     * @property useConfigurationAttributeInternalIPSubnet
     * @discussion Boolean indicating if client should use INTERNAL_IP4_SUBNET / INTERNAL_IP6_SUBNET attributes.  Default is False.
     */
    @available(macOS 10.11, *)
    open var useConfigurationAttributeInternalIPSubnet: Bool

    /**
     * @property IKESecurityAssociationParameters
     * @discussion Parameters for the IKE SA
     */
    @available(macOS 10.11, *)
    open var ikeSecurityAssociationParameters: NEVPNIKEv2SecurityAssociationParameters { get }

    /**
     * @property childSecurityAssociationParameters
     * @discussion Parameters for the child SA
     */
    @available(macOS 10.11, *)
    open var childSecurityAssociationParameters: NEVPNIKEv2SecurityAssociationParameters { get }

    /**
     * @property disableMOBIKE
     * @discussion Disable MOBIKE negotiation. Default is NO.
     */
    @available(macOS 10.11, *)
    open var disableMOBIKE: Bool

    /**
     * @property disableRedirect
     * @discussion Disable Server Redirect. Default is NO.
     */
    @available(macOS 10.11, *)
    open var disableRedirect: Bool

    /**
     * @property enablePFS
     * @discussion Enable Perfect Forward Secrecy. Default is NO.
     */
    @available(macOS 10.11, *)
    open var enablePFS: Bool

    /**
     * @property allowPostQuantumKeyExchangeFallback
     * @discussion Allow servers that do not support post-quantum key exchanges to skip them. This property has no effect if no post-quantum key exchange methods
     *     are configured for the IKE SA or Child SA (see NEVPNIKEv2SecurityAssociationParameters.postQuantumKeyExchangeMethods). Default is NO.
     */
    @available(macOS 26.0, *)
    open var allowPostQuantumKeyExchangeFallback: Bool

    /**
     * @property enableRevocationCheck
     * @discussion Enable certificate revocation check. Default is NO.
     */
    @available(macOS 10.11, *)
    open var enableRevocationCheck: Bool

    /**
     * @property strictRevocationCheck
     * @discussion Require positive certificate revocation check response for peer certificate validation to pass. Default is NO.
     */
    @available(macOS 10.11, *)
    open var strictRevocationCheck: Bool

    /**
     * @property minimumTLSVersion
     * @discussion Sets a minimum TLS version to allow for EAP-TLS authentication. Default is NEVPNIKEv2TLSVersionDefault.
     */
    @available(macOS 10.13, *)
    open var minimumTLSVersion: NEVPNIKEv2TLSVersion

    /**
     * @property maximumTLSVersion
     * @discussion Sets a maximum TLS version to allow for EAP-TLS authentication. Default is NEVPNIKEv2TLSVersionDefault.
     */
    @available(macOS 10.13, *)
    open var maximumTLSVersion: NEVPNIKEv2TLSVersion

    /**
     * @property mtu
     * @discussion Maximum Transmission Unit (MTU) size in bytes to assign to the tunnel interface.
     */
    @available(macOS 11.0, *)
    open var mtu: Int

    /**
     * @property ppkConfiguration
     * @discussion Configuration for the use of a Post-quantum Pre-shared Key (PPK).
     */
    @available(macOS 15.0, *)
    @NSCopying open var ppkConfiguration: NEVPNIKEv2PPKConfiguration?
}

/**
 * @interface NWEndpoint
 * @discussion NWEndpoint is a generic class to represent network endpoints, such as a port on a remote server.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use nw_endpoint_t in Network framework instead, see deprecation notice in <NetworkExtension/NWEndpoint.h>")
open class NWEndpoint : NSObject, NSSecureCoding, NSCopying {
}

/**
 * @interface NWHostEndpoint
 * @discussion NWHostEndpoint is a subclass of NWEndpoint. It represents an endpoint backed by a
 *        hostname and port. Note that a hostname string may be an IP or IPv6 address.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWHostEndpoint.h>")
open class NWHostEndpoint : NWEndpoint {

    /**
     * @method endpointWithHostname:port:
     * @param hostname A string representation of the hostname or address, such as www.apple.com or 10.0.0.1.
     * @param port A string containing the port on the host, such as 80.
     * @return An initialized NWHostEndpoint object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_create_host` in Network framework instead, see deprecation notice in <NetworkExtension/NWHostEndpoint.h>")
    public convenience init(hostname: String, port: String)

    /**
     * @property hostname
     * @discussion The endpoint's hostname.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_get_hostname` in Network framework instead, see deprecation notice in <NetworkExtension/NWHostEndpoint.h>")
    open var hostname: String { get }

    /**
     * @property port
     * @discussion The endpoint's port.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_get_port` in Network framework instead, see deprecation notice in <NetworkExtension/NWHostEndpoint.h>")
    open var port: String { get }
}

/**
 * @interface NWBonjourServiceEndpoint
 * @discussion NWBonjourServiceEndpoint is a subclass of NWEndpoint. It represents an endpoint
 *        backed by a Bonjour service, specified with a name, type, and domain. For example, the
 *        Bonjour service MyMusicStudio._music._tcp.local. has the name "MyMusicStudio",
 *        the type "_music._tcp", and the domain "local".
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWBonjourServiceEndpoint.h>")
open class NWBonjourServiceEndpoint : NWEndpoint {

    /**
     * @method endpointWithName:type:domain:
     * @param name The Bonjour service name.
     * @param type The Bonjour service type.
     * @param domain The Bonjour service domain.
     * @return An initialized NWBonjourServiceEndpoint object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_create_bonjour_service` in Network framework instead, see deprecation notice in <NetworkExtension/NWBonjourServiceEndpoint.h>")
    public convenience init(name: String, type: String, domain: String)

    /**
     * @property name
     * @discussion The endpoint's Bonjour service name.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_get_bonjour_service_name` in Network framework instead, see deprecation notice in <NetworkExtension/NWBonjourServiceEndpoint.h>")
    open var name: String { get }

    /**
     * @property type
     * @discussion The endpoint's Bonjour service type.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_get_bonjour_service_type` in Network framework instead, see deprecation notice in <NetworkExtension/NWBonjourServiceEndpoint.h>")
    open var type: String { get }

    /**
     * @property domain
     * @discussion The endpoint's Bonjour service domain.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_get_bonjour_service_domain` in Network framework instead, see deprecation notice in <NetworkExtension/NWBonjourServiceEndpoint.h>")
    open var domain: String { get }
}

/**
 * @typedef NWPathStatus
 * @abstract Path status values
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_status_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWPath.h>")
public enum NWPathStatus : Int, @unchecked Sendable {

    /** @const NWPathStatusInvalid The path cannot be evaluated. */
    case invalid = 0

    /** @const NWPathStatusSatisfied The path is ready to be used for traffic. */
    case satisfied = 1

    /** @const NWPathStatusUnsatisfied The network for this connection is not available. */
    case unsatisfied = 2

    /** @const NWPathStatusSatisfiable The path may become satisfied upon
         *        a connection attempt. */
    case satisfiable = 3
}

/**
 * @interface NWPath
 * @discussion A network path, represented with NWPath, expresses the viability status and
 *        properties of the path that a networking connection will take on the device. For example,
 *        if the path status is NWPathStatusSatisfied, then a connection could use that path.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWPath.h>")
open class NWPath : NSObject {

    /**
     * @property status
     * @discussion The evaluated NWPathStatus of the NWPath.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_get_status` in Network framework instead, see deprecation notice in <NetworkExtension/NWPath.h>")
    open var status: NWPathStatus { get }

    /**
     * @property expensive
     * @discussion Returns YES if the path is considered expensive, as when using a cellular data plan.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_is_expensive` in Network framework instead, see deprecation notice in <NetworkExtension/NWPath.h>")
    open var isExpensive: Bool { get }

    /**
     * @property constrained
     * @discussion Returns YES if the path is considered constrained, as when it is in save data mode.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_is_constrained` in Network framework instead, see deprecation notice in <NetworkExtension/NWPath.h>")
    open var isConstrained: Bool { get }

    /**
     * @method isEqualToPath:
     * @param path An NWPath object to compare.
     * @return YES if the two path objects have the same content, NO otherwise.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_is_equal` in Network framework instead, see deprecation notice in <NetworkExtension/NWPath.h>")
    open func isEqual(to path: NWPath) -> Bool
}

/**
 * @typedef NWTCPConnectionState
 * @abstract Defined connection states. New types may be defined in the future.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_state_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
public enum NWTCPConnectionState : Int, @unchecked Sendable {

    /** @constant NWTCPConnectionStateInvalid The connection is in an invalid or uninitialized state */
    case invalid = 0

    /** @constant NWTCPConnectionStateConnecting The connection is attempting */
    case connecting = 1

    /** @constant NWTCPConnectionStateWaiting The connection has attempted but failed. It is now
         *        waiting for better condition(s) before trying again.
         */
    case waiting = 2

    /** @constant NWTCPConnectionStateConnected The connection is established. It is now possible
         *        to transfer data. If TLS is in use, the TLS handshake would have finished when the connection
         *        is in this state.
         */
    case connected = 3

    /** @constant NWTCPConnectionStateDisconnected The connection is disconnected. It is no longer
         *        possible to transfer data. The application should call cancellation method to clean up resources
         *        when the connection is in this state.
         */
    case disconnected = 4

    /** @constant NWTCPConnectionStateCancelled The connection is cancelled. This is triggered by
         *        the cancellation method.
         */
    case cancelled = 5
}

/**
 * @interface NWTCPConnection
 * @discussion Establish TCP connections to an endpoint, and send and receive data on the TCP connection.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
open class NWTCPConnection : NSObject {

    /**
     * @method initWithUpgradeForConnection:
     * @discussion This convenience initializer can be used to create a new connection that would only
     *         be connected if there exists a better path (as determined by the system) to the destination
     *         endpoint of the original connection. It will be initialized using the same destination endpoint
     *         and set of parameters from the original connection.
     *
     *         If the original connection becomes disconnected or cancelled, the new "upgrade" connection
     *         would automatically be considered better.
     *
     *        The caller should create an NWTCPConnection and watch for the hasBetterPath property.
     *        When this property is YES, the caller should attempt to create a new upgrade
     *        connection, with the goal to start transferring data on the new better path as soon as
     *        possible to reduce power and potentially monetary cost. When the new upgrade connection
     *        becomes connected and when the caller wraps up the previous caller session on
     *        the original connection, the caller can start using the new upgrade connection and
     *        tear down the original one.
     *
     * @param connection The original connection from which the caller will upgrade
     * @return An initialized NWTCPConnection
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_create` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    public init(upgradeFor connection: NWTCPConnection)

    /**
     * @property state
     * @discussion The status of the connection. Use KVO to watch this property to get updates.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_state_changed_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var state: NWTCPConnectionState { get }

    /**
     * @property viable
     * @discussion YES if the connection can read and write data, NO otherwise. Use KVO to watch this property.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_viability_changed_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var isViable: Bool { get }

    /**
     * @property hasBetterPath
     * @discussion YES if the system determines there is a better path the destination can be reached if
     *        the caller creates a new connection using the same endpoint and parameters. This can
     *        be done using the convenience upgrade initializer method.
     *        Use KVO to watch this property to get updates.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_better_path_available_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var hasBetterPath: Bool { get }

    /**
     * @property endpoint
     * @discussion The destination endpoint with which this connection was created.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_copy_endpoint` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var endpoint: NWEndpoint { get }

    /**
     * @property connectedPath
     * @discussion The network path over which the connection was established. The caller can query
     *        additional properties from the NWPath object for more information.
     *
     *         Note that this contains a snapshot of information at the time of connection establishment
     *         for this connection only. As a result, some underlying properties might change in time and
     *         might not reflect the path for other connections that might be established at different times.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_copy_current_path` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var connectedPath: NWPath? { get }

    /**
     * @property localAddress
     * @discussion The IP address endpoint from which the connection was connected.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_copy_effective_local_endpoint` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var localAddress: NWEndpoint? { get }

    /**
     * @property remoteAddress
     * @discussion The IP address endpoint to which the connection was connected.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_path_copy_effective_remote_endpoint` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var remoteAddress: NWEndpoint? { get }

    /**
     * @property txtRecord
     * @discussion When the connection is connected to a Bonjour service endpoint, the TXT record associated
     *         with the Bonjour service is available via this property. Beware that the value comes from
     *         the network. Care must be taken when parsing this potentially malicious value.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_endpoint_copy_txt_record` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var txtRecord: Data? { get }

    /**
     * @property error
     * @discussion The connection-wide error property indicates any fatal error that occurred while
     *         processing the connection or performing data reading or writing.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_state_changed_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open var error: (any Error)? { get }

    /**
     * @method cancel:
     * @discussion Cancel the connection. This will clean up the resources associated with this object
     *         and transition this object to NWTCPConnectionStateCancelled state.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_cancel` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open func cancel()

    /**
     * @method readLength:completionHandler:
     * @discussion Read "length" number of bytes. See readMinimumLength:maximumLength:completionHandler:
     *         for a complete discussion of the callback behavior.
     * @param length The exact number of bytes the application wants to read
     * @param completion The completion handler to be invoked when there is data to read or an error occurred
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_receive` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open func readLength(_ length: Int, completionHandler completion: @escaping (Data?, (any Error)?) -> Void)

    /**
     * @method readMinimumLength:maximumLength:completionHandler:
     *
     * @discussion Read the requested range of bytes. The completion handler will be invoked when:
     *         - Exactly "length" number of bytes have been read. 'data' will be non-nil.
     *
     *         - Fewer than "length" number of bytes, including 0 bytes, have been read, and the connection's
     *         read side has been closed. 'data' might be nil, depending on whether there was any data to be
     *         read when the connection's read side was closed.
     *
     *         - Some fatal error has occurred, and 'data' will be nil.
     *
     *         To know when to schedule a read again, check for the condition whether an error has occurred.
     *
     *        For better performance, the caller should pick the effective minimum and maximum lengths.
     *        For example, if the caller absolutely needs a specific number of bytes before it can
     *        make any progress, use that value as the minimum. The maximum bytes can be the upperbound
     *        that the caller wants to read. Typically, the minimum length can be the caller
     *        protocol fixed-size header and the maximum length can be the maximum size of the payload or
     *        the size of the current read buffer.
     *
     * @param minimum The minimum number of bytes the caller wants to read
     * @param maximum The maximum number of bytes the caller wants to read
     * @param completion The completion handler to be invoked when there is data to read or an error occurred
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_receive` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open func readMinimumLength(_ minimum: Int, maximumLength maximum: Int, completionHandler completion: @escaping (Data?, (any Error)?) -> Void)

    /**
     * @method write:completionHandler:
     * @discussion Write the given data object content. Callers should wait until the completionHandler is executed
     *        before issuing another write.
     * @param data The data object whose content will be written
     * @param completion The completion handler to be invoked when the data content has been written or an error has occurred.
     *         If the error is nil, the write succeeded and the caller can write more data.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_send` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open func write(_ data: Data, completionHandler completion: @escaping ((any Error)?) -> Void)

    /**
     * @method writeClose:
     * @discussion Close this connection's write side such that further write requests won't succeed.
     *         Note that this has the effect of closing the read side of the peer connection.
     *         When the connection's read side and write side are closed, the connection is considered
     *         disconnected and will transition to the appropriate state.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_send` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    open func writeClose()
}

/**
 * @protocol NWTCPConnectionAuthenticationDelegate
 * @discussion Allows the caller to take custom actions on some connection events.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
public protocol NWTCPConnectionAuthenticationDelegate : NSObjectProtocol {

    /**
     * @method shouldProvideIdentityForConnection:
     * @discussion The caller can implement this optional protocol method to decide whether it
     *        wants to provide the identity for this connection for authentication. If this delegate
     *        method is not implemented, the return value will default to YES if
     *        provideIdentityForConnection:completionHandler: is implemented.
     * @param connection The connection sending this message
     * @return YES to provide the identity for this connection, in which case, the delegate method
     *        provideIdentityForConnection:completionHandler: will be called.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_challenge_block` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    optional func shouldProvideIdentity(for connection: NWTCPConnection) -> Bool

    /**
     * @method provideIdentityForConnection:completionHandler:
     * @discussion The caller can implement this optional protocol method to provide the identity
     *        and an optional certificate chain to be used for authentication.
     * @param connection The connection sending this message
     * @param completion The completion handler for passing identity and certificate chain to the connection.
     *        The "identity" argument is required and must not be nil. The "certificateChain" argument is optional,
     *        and is an array of one or more SecCertificateRef objects. The certificate chain must contain objects
     *        of type SecCertificateRef only. If the certificate chain is set, it will be used. Otherwise, the leaf
     *        certificate will be extracted from the SecIdentityRef object and will be used for authentication.
     *
     *        The caller is responsible for keeping the argument object(s) alive for the duration of the
     *        completion handler invocation.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_challenge_block` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    optional func provideIdentity(for connection: NWTCPConnection, completionHandler completion: @escaping (SecIdentity, [Any]) -> Void)

    /**
     * @method shouldEvaluateTrustForConnection:
     * @discussion The caller can implement this optional protocol method to decide whether it
     *        wants to take over the default trust evaluation for this connection. If this delegate method
     *        is not implemented, the return value will default to YES if
     *        provideIdentityForConnection:completionHandler: is implemented.
     * @param connection The connection sending this message
     * @return YES to take over the default trust evaluation, in which case, the delegate method
     *        evaluateTrustForConnection:peerCertificateChain:completionHandler: will be called.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_verify_block` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    optional func shouldEvaluateTrust(for connection: NWTCPConnection) -> Bool

    /**
     * @method evaluateTrustForConnection:peerCertificateChain:completionHandler:
     * @discussion The caller can implement this optional protocol method to set up custom policies
     *        for peer certificate trust evaluation. If the delegate method is implemented, the caller
     *        is responsible for creating and setting up the SecTrustRef object and passing it to the
     *        completion handler. Otherwise, the default trust evaluation policy is used for the connection.
     * @param connection The connection sending this message
     * @param peerCertificateChain The peer certificate chain
     * @param completion The completion handler for passing the SecTrustRef object to the connection.
     *        The SecTrustRef object "trust" is required and must not be nil. It will be evaluated using
     *        SecTrustEvaluate() if necessary. The caller is responsible for keeping the argument object
     *        alive for the duration of the completion handler invocation.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_verify_block` in Network framework instead, see deprecation notice in <NetworkExtension/NWTCPConnection.h>")
    optional func evaluateTrust(for connection: NWTCPConnection, peerCertificateChain: [Any], completionHandler completion: @escaping (SecTrust) -> Void)
}

/**
 * @typedef NWUDPSessionState
 * @abstract UDP session state values
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_state_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
public enum NWUDPSessionState : Int, @unchecked Sendable {

    /** @constant NWUDPSessionStateInvalid The session is in an invalid or uninitialized state. */
    case invalid = 0

    /** @constant NWUDPSessionStateWaiting The session is waiting for better conditions before
         *        attempting to make the session ready.
         */
    case waiting = 1

    /** @constant NWUDPSessionStatePreparing The endpoint is being resolved */
    case preparing = 2

    /** @constant NWUDPSessionStateReady The session is ready for reading and writing data */
    case ready = 3

    /** @constant NWUDPSessionStateFailed None of the currently resolved endpoints can be used
         *        at this time, either due to problems with the path or the client rejecting the
         *        endpoints.
         */
    case failed = 4

    /** @constant NWUDPSessionStateCancelled The session has been cancelled by the client */
    case cancelled = 5
}

/**
 * @interface NWUDPSession
 * @discussion Open UDP datagram sessions to an endpoint, and send and receive datagrams.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_t` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
open class NWUDPSession : NSObject {

    /**
     * @method initWithUpgradeForSession:
     * @discussion This convenience initializer can be used to create a new session based on the
     *        original session's endpoint and parameters.
     *
     *        The application should create an NWUDPSession and watch the "hasBetterPath" property.
     *        When this property is YES, it should call initWithUpgradeForSession: to create a new
     *        session, with the goal to start transferring data on the new better path as soon as
     *        possible to reduce power and potentially monetary cost. When the new "upgrade" session
     *        becomes ready and when the application wraps up the previous application session on
     *        the original session, the application can start using the new "upgrade" session and
     *        tear down the original one.
     *
     * @param session The original session from which the application will upgrade
     * @return An initialized NWUDPSession object.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_create` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    public init(upgradeFor session: NWUDPSession)

    /**
     * @property state
     * @discussion The current state of the UDP session. If the state is NWUDPSessionStateReady,
     *        then the connection is eligible for reading and writing. The state will be
     *        NWUDPSessionStateFailed if the endpoint could not be resolved, or all endpoints have been
     *        rejected. Use KVO to watch for changes.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_state_changed_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var state: NWUDPSessionState { get }

    /**
     * @property endpoint
     * @discussion The provided endpoint.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_copy_endpoint` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var endpoint: NWEndpoint { get }

    /**
     * @property resolvedEndpoint
     * @discussion The currently targeted remote endpoint. Use KVO to watch for changes.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_copy_current_path` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var resolvedEndpoint: NWEndpoint? { get }

    /**
     * @property viable
     * @discussion YES if the connection can read and write data, NO otherwise.
     *        Use KVO to watch this property.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_viability_changed_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var isViable: Bool { get }

    /**
     * @property hasBetterPath
     * @discussion YES if there is another path available that is preferred over the currentPath.
     *        To take advantage of this path, create a new UDPSession. Use KVO to watch for changes.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_set_better_path_available_handler` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var hasBetterPath: Bool { get }

    /**
     * @property currentPath
     * @discussion The current evaluated path for the resolvedEndpoint. Use KVO to watch for changes.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_copy_current_path` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var currentPath: NWPath? { get }

    /**
     * @method tryNextResolvedEndpoint
     * @discussion Mark the current value of resolvedEndpoint as unusable, and try to switch to the
     *        next available endpoint. This should be used when the caller has attempted to communicate
     *        with the current resolvedEndpoint, and the caller has determined that it is unusable. If
     *        there are no other resolved endpoints, the session will move to the failed state.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_cancel_current_endpoint` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open func tryNextResolvedEndpoint()

    /**
     * @property maximumDatagramLength
     * @discussion The maximum size of a datagram to be written currently. If a datagram is written
     *        with a longer length, the datagram may be fragmented or encounter an error. Note that this
     *        value is not guaranteed to be the maximum datagram length for end-to-end communication
     *        across the network. Use KVO to watch for changes.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_get_maximum_datagram_size` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open var maximumDatagramLength: Int { get }

    /**
     * @method setReadHandler:maxDatagrams
     * @discussion Set a read handler for datagrams. Reads will be scheduled by the system, so this
     *        method only needs to be called once for a session.
     * @param handler A handler called when datagrams have been read, or when an error has occurred.
     * @param maxDatagrams The maximum number of datagrams to send to the handler.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_receive` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open func setReadHandler(_ handler: @escaping ([Data]?, (any Error)?) -> Void, maxDatagrams: Int)

    /**
     * @method writeMultipleDatagrams:completionHandler
     * @discussion Write multiple datagrams. Callers should wait until the completionHandler is executed
     *        before issuing another write.
     * @param datagramArray An NSArray of NSData objects, containing the ordered list datagrams to write.
     * @param completionHandler A handler called when the write request has either succeeded or failed.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_send` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open func writeMultipleDatagrams(_ datagramArray: [Data], completionHandler: @escaping ((any Error)?) -> Void)

    /**
     * @method writeDatagram:completionHandler
     * @discussion Write a single datagram. Callers should wait until the completionHandler is executed
     *        before issuing another write.
     * @param datagram An NSData containing the datagram to write.
     * @param completionHandler A handler called when the write request has either succeeded or failed.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_send` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open func writeDatagram(_ datagram: Data, completionHandler: @escaping ((any Error)?) -> Void)

    /**
     * @method cancel
     * @discussion Move into the NWUDPSessionStateCancelled state. The connection will be terminated,
     *        and all handlers will be cancelled.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `nw_connection_cancel` in Network framework instead, see deprecation notice in <NetworkExtension/NWUDPSession.h>")
    open func cancel()
}

/**
 * DEPRECATION NOTICE
 *
 * NW object wrappers are hidden in Swift 6. To continue accessing them, you
 * can prepend double underscores to the symbol name.
 */
@available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_t` in Security framework instead, see deprecation notice in <NetworkExtension/NWTLSParameters.h>")
open class NWTLSParameters : NSObject {

    /**
     * @property TLSSessionID
     * @discussion The session ID for the associated connection, used for TLS session resumption.
     *        This property is optional when using TLS.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_tls_resumption_enabled` in Security framework instead, see deprecation notice in <NetworkExtension/NWTLSParameters.h>")
    open var tlsSessionID: Data?

    /**
     * @property SSLCipherSuites
     * @discussion The set of allowed cipher suites, as defined in <Security/CipherSuite.h>.
     *        If set to nil, the default cipher suites will be used.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_append_tls_ciphersuite` in Security framework instead, see deprecation notice in <NetworkExtension/NWTLSParameters.h>")
    open var sslCipherSuites: Set<NSNumber>?

    /**
     * @property minimumSSLProtocolVersion
     * @discussion The minimum allowed SSLProtocol value. as defined in <Security/SecureTransport.h>.
     *        If set, the SSL handshake will not accept any protocol version older than the minimum.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_min_tls_protocol_version` in Security framework instead, see deprecation notice in <NetworkExtension/NWTLSParameters.h>")
    open var minimumSSLProtocolVersion: Int

    /**
     * @property maximumSSLProtocolVersion
     * @discussion The maximum allowed SSLProtocol value. as defined in <Security/SecureTransport.h>.
     *        If set, the SSL handshake will not accept any protocol version newer than the maximum.
     *        This property should be used with caution, since it may limit the use of preferred
     *        SSL protocols.
     */
    @available(macOS, introduced: 10.11, deprecated: 15.0, message: "Use `sec_protocol_options_set_max_tls_protocol_version` in Security framework instead, see deprecation notice in <NetworkExtension/NWTLSParameters.h>")
    open var maximumSSLProtocolVersion: Int
}

extension NEURLFilter {

    /// URL Filter Verdicts
    @available(macOS 26.0, *)
    public enum Verdict : Int, @unchecked Sendable {

        /** @const NEURLFilterVerdictUnknown The validation failed */
        case unknown = 1

        /** @const NEURLFilterVerdictAllow URL should be allowed */
        case allow = 2

        /** @const NEURLFilterVerdictDeny URL should be denied. */
        case deny = 3
    }
}

open class NEURLFilter : NSObject {
}

/// This file declares the NEURLFilter API.  For Applications that are not using any of the Apple Networking frameworks
/// (WebKit, CFNetwork and Network frameworks), use the NEURLFilter API to voluntarily validate URLs before potentially
/// connecting to any restricted or malicious Internet site.  This API checks the specified URL and returns a Allow or Deny
/// verdict.  Applications should not connect to any URLs with the Deny result.
/// This API is part of NetworkExtension.framework.
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilter {

    /// This method determines if the specified URL should be allowed or denied.  The returned Allow or Deny verdict should be honored to prevent
    /// communication with restricted or malicious Internet sites.
    /// - Parameters:
    ///   - url: url to be validated
    /// - Returns
    ///   - NEURLFilter.Verdict: A NEURLFilter.Verdict will be returned to indicate whether the specified URL should be allowed or denied.  If verdict is
    ///   Deny, caller should fail the URL request.
    public class func verdict(for url: URL) async -> NEURLFilter.Verdict
}

/// The NEAppExtensionConfiguration class adopts AppExtensionConfiguration protocol. The class
/// defines methods and properties required for the communication between the  app extension
/// and the NetworkExtension Framework.
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@MainActor @preconcurrency public class NEAppExtensionConfiguration : AppExtensionConfiguration {

    /// Accepts incoming XPC connections from the host process.
    nonisolated public func accept(connection: NSXPCConnection) -> Bool

    @objc deinit
}

/// Subclasses of NEAppProxyProvider and NEDNSProxyProvider can conform to this protocol to receive UDP data flows.
@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
public protocol NEAppProxyUDPFlowHandling {

    /// This function is called by the framework to deliver a new UDP data flow to the proxy provider implementation.
    ///
    /// The proxy provider implementation indicates that the proxy is ready to handle flow data by calling `NEAppProxyFlow.open(withLocalFlowEndpoint:)` on the flow. If the proxy implementation decides to not handle the flow and instead terminate it, the implementation of this method should return `false`. If the proxy implementation decides to handle the flow, the subclass implementation of this method should return `true`. In this case the proxy implementation is responsible for retaining the NEAppProxyUDPFlow object. The default implementation of this method calls `handleNewFlow(_:)` and returns its result.
    ///
    /// - Parameters:
    ///   - flow: The new UDP flow
    ///   - remoteEndpoint: The initial remote endpoint provided by the proxied app when the flow was opened.
    /// - Returns: `true` if the proxy implementation has retained the flow and intends to handle the flow data. `false` if the proxy implementation has not retained the flow and will not handle the flow data. In this case the flow is terminated.
    func handleNewUDPFlow(_ flow: NEAppProxyUDPFlow, initialRemoteFlowEndpoint remoteEndpoint: NWEndpoint) -> Bool
}

/// The NEURLFilterControlProvider protocol defines the programmatic interface for an object that is responsible for fetching pre-filter data.
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
public protocol NEURLFilterControlProvider : AppExtension {

    /// This function is called by the framework when the URL filter is being started.  Subclass must override this method and perform
    /// whatever steps are necessary to prepare for fetching pre-filter data.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    func start() async throws

    /// This function is called by the framework when the URL filter is being stopped. Subclass must override this method and perform
    /// whatever steps are necessary before the filter is stopped.
    /// - Parameters:
    ///   - reason: An NEProviderStopReason indicating why the filter is being stopped.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    func stop(reason: NEProviderStopReason) async throws

    /// This function is called by the framework to periodically fetch pre-filter data.  The framework will call this
    /// method at the frequency specified via the NEURLFilterManager API.  Subclass must override this method
    /// to perform whatever steps are necessary to fetch pre-filter data.  The first call to this method must return
    /// a non-nil Bloom filter.  For subsequent calls, a nil Bloom filter will post no change to the current Bloom
    /// Filter and the framework will continue to use the current Bloom filter.
    ///
    /// The fetched pre-filter data must be a Bloom filter using the 32-bit FNV-1a and 32-bit MurmurHash3 hash
    /// functions, with double hashing.  Both FNV-1a and MurmurHash3 hash functions are fast non-cryptographic
    /// hash functions that produce good distribution.  Adding double hashing will further improve the spread
    /// and distribution of hash values over a Bloom filter's bit array.
    ///
    /// Note that the numberOfBits and numberOfHashes are calculated based on number of items in the data set
    /// as well as the false-positive tolerance selected for the Bloom filter.  The selected false-positive
    /// tolerance must be relatively low to allow for accurate and efficient pre-filtering.
    ///
    ///   Given the number of items in the data set, n, select the false-positive tolerance, p, in the range
    ///   between 0.0 and 1.0, excluding the bounds.
    ///
    ///      numberOfBits - calculate number of bits in Bloom filter
    ///            numberOfBits = -n * ln(p) / (ln(2) ^ 2)
    ///
    ///   numberOfHashes - calculate number of hashes
    ///            numberOfHashes = (numberOfBits / n) * ln(2)
    ///
    /// Composition of the Bloom filter as well as membership testing must deploy the same indexing operations,
    /// where x is the data string to be inserted or checked:
    ///
    ///     h1(x) = FNV-1a(x)
    ///     h2(x) = MurmurHash3(x) with murmurSeed
    ///
    ///     for each index i in the range from 0 to < numberOfHashes
    ///         hashes[i] = (h1(x) + i * h2(x)) mod numberOfBits
    ///
    /// For Composition, set the bits to 1 at each of the positions in hashes[].  For membership testing, verify
    /// if all the bits at positions in hashes[] are 1.
    ///
    /// The input data set contains URLs you want to block.  All URLs in the data set must be already puny-coded before
    /// construction of the Bloom filter.
    ///
    /// Provider implementation can either return the complete Bloom filter data if the Bloom filter data is relatively
    /// small.  Otherwise, implementation can save the Bloom filter data in a temporary file and return the file path.
    /// The system will clean up the temporary file once the Bloom filter data is consumed.
    ///
    /// - Parameters
    ///        - existingPrefilterTag: tag of the current Bloom filter.  The system will pass the tag of the last fetched
    ///        Bloom filter.  Nil will be passed for the initial fetch.  Implementation can use this tag to decide if a
    ///        Bloom filter update is necessary.  If update is not necessary, return nil to indicate to system to
    ///        continue use of the current Bloom filter.
    /// - Returns
    ///        - NEURLFilterPrefilter: struct containing the prefilter information.  A valid NEURLFilterPrefilter is required for the initial fetch.
    ///        A nil NEURLFilterPrefilter for subsequent fetch indicates no change, and system will continue to use current prefilter data.
    /// - throws
    ///        - Error: returns optional error to indicate the fail reason.
    func fetchPrefilter(existingPrefilterTag: String?) async throws -> NEURLFilterPrefilter?
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterControlProvider {

    /// Object that holds configuration options for NEURLFilterControlProvider
    public var configuration: some NEAppExtensionConfiguration { get }
}

/// Manages NEURLFilterControlProvider's communication with the framework
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
@MainActor @preconcurrency public class NEURLFilterControlProviderConfiguration : NEAppExtensionConfiguration {

    @objc deinit
}

/// The NEURLFilterManager class declares the programmatic interface for an object that manages URL filtering configurations.
/// NEURLFilterManager declares methods and properties for configuring and controlling a URL filter.
/// Instances of this class are thread safe.
///
/// URL Filtering is performed by the system on your behalf according to your configuration and URL data set.  The system filters
/// all URL requests initiated with Webkit and URLSession APIs.  During URL filtering, the system performs sub-URL generation to
/// enumurate all possible sub-URLs for the URL in question.  For example, the URL
///
///     https://www.example.com/a/b/c?id=123#fragment
///
/// will be parsed into the following sub-URLs:
///
/// example.com
/// example.com/
/// www.example.com
/// www.example.com/
/// example.com/a
/// example.com/a/
/// www.example.com/a
/// www.example.com/a/
/// example.com/a/b
/// example.com/a/b/
/// www.example.com/a/b
/// www.example.com/a/b/
/// example.com/a/b/c
/// example.com/a/b/c/
/// www.example.com/a/b/c
/// www.example.com/a/b/c/
/// example.com/a/b/c?id=123
/// example.com/a/b/c?id=123/
/// www.example.com/a/b/c?id=123
/// example.com/a/b/c?id=123#fragment
/// www.example.com/a/b/c?id=123/
/// www.example.com/a/b/c?id=123#fragment
/// example.com/a/b/c?id=123#fragment/
/// www.example.com/a/b/c?id=123#fragment/
///
/// Each of these sub-URLs is matched against your Bloom filter and then against the PIR URL database if there is a Bloom filter match.
/// The verdict indicates if the requested URL should be blocked.  Note that the requested URL will be puny-coded before parsing,
/// therefore, your URL dataset must also be puny-coded before constructing your Bloom filter and PIR database.  Wildcards and regular
/// expressions are not supported by either Bloom filter or PIR.
///
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
public class NEURLFilterManager : @unchecked Sendable {

    /// URL Filter status codes
    public enum Status : Int, @unchecked Sendable {

        /// The URL filter is not configured.
        case invalid

        /// The URL filter is not running.
        case stopped

        /// The URL filter is starting.
        case starting

        /// The URL filter is running.
        case running

        /// The URL filter is stopping.
        case stopping

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional(PaperSize.Legal)"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: Int)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 26.0, macOS 26.0, *)
        @available(tvOS, unavailable)
        @available(watchOS, unavailable)
        @available(visionOS, unavailable)
        public typealias RawValue = Int

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: Int { get }
    }

    /// URL Filter error codes
    public enum Error : Int, LocalizedError {

        /// The filter configuration is unchanged.
        case configurationUnchanged

        /// The filter configuration is invalid.
        case configurationInvalid

        /// The filter configuration is disabled.
        case configurationDisabled

        /// The filter configuration needs to be loaded.
        case configurationStale

        /// The filter configuration cannot be removed.
        case configurationCannotBeRemoved

        /// Operation permission denied.
        case configurationPermissionDenied

        /// An internal configuration error occurred.
        case configurationInternalError

        /// Configuration has not been loaded.
        case configurationNotLoaded

        /// PIR Server or/and OHTTP Private Relay setup incomplete.
        case serverSetupIncomplete

        /// An internal error occurred.
        case internalError

        /// The app extension cancelled the feature bringup.
        case extensionCancelled

        /// The app extension is not found.
        case extensionNotFound

        /// The app extension failed to load.
        case extensionFailedToLoad

        /// Unknown error.
        case unknown

        /// Creates a new instance with the specified raw value.
        ///
        /// If there is no value of the type that corresponds with the specified raw
        /// value, this initializer returns `nil`. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     print(PaperSize(rawValue: "Legal"))
        ///     // Prints "Optional(PaperSize.Legal)"
        ///
        ///     print(PaperSize(rawValue: "Tabloid"))
        ///     // Prints "nil"
        ///
        /// - Parameter rawValue: The raw value to use for the new instance.
        public init?(rawValue: Int)

        /// The raw type that can be used to represent all values of the conforming
        /// type.
        ///
        /// Every distinct value of the conforming type has a corresponding unique
        /// value of the `RawValue` type, but there may be values of the `RawValue`
        /// type that don't have a corresponding value of the conforming type.
        @available(iOS 26.0, macOS 26.0, *)
        @available(tvOS, unavailable)
        @available(watchOS, unavailable)
        @available(visionOS, unavailable)
        public typealias RawValue = Int

        /// The corresponding value of the raw type.
        ///
        /// A new instance initialized with `rawValue` will be equivalent to this
        /// instance. For example:
        ///
        ///     enum PaperSize: String {
        ///         case A4, A5, Letter, Legal
        ///     }
        ///
        ///     let selectedSize = PaperSize.Letter
        ///     print(selectedSize.rawValue)
        ///     // Prints "Letter"
        ///
        ///     print(selectedSize == PaperSize(rawValue: selectedSize.rawValue)!)
        ///     // Prints "true"
        public var rawValue: Int { get }
    }

    /// The singleton NEURLFilterManager object for the calling process.
    public static var shared: NEURLFilterManager { get }

    @objc deinit

    /// Toggles the enabled status of the URL filter. If YES, the URL filter will start filtering URLs. If NO, the URL filter will cease URL filtering.
    /// Defaults to NO.
    public var isEnabled: Bool

    /// If YES, URLs will be blocked if the filter is enabled but failed to make any filtering decision (e.g. communication failure
    /// with the PIR server).  If NO, URLs will be allowed if the filter is enabled but failed to make any filtering decision.  Default is NO.
    public var shouldFailClosed: Bool

    /// The time interval at which the NEURLFilterControlProvider app extension will run.  Defaults to every 86,400 seconds (1 day).
    /// Minimum allowed is 2700 seconds (45 minutes).  NEURLFilterControlProvider implementation will be able to download prefilter
    /// Bloom filter data onto device periodically at the specified interval.  Due to scheduling mechanism on the system, implementation
    /// should allow slight deviation between the scheduled time and the actual execution time of the task.
    public var prefilterFetchInterval: TimeInterval

    /// A string containing a description of the URL filter.
    public var localizedDescription: LocalizedStringResource?

    /// Bundle Identifier of the URL filter app.
    public var appBundleIdentifier: String? { get }

    /// Bundle Identifier of the NEURLFilterControlProvider app extension.
    public var controlProviderBundleIdentifier: String? { get }

    /// URL containing the domain name of the PIR server. URL filter App implementation must set up a PIR server
    /// (hosting a URL dataset) reachable at the specified PIR server URL.  For all HTTP requests made using any of
    /// the Apple networking frameworks, NetworkExtension system validates the requested URL via the PIR
    /// technology with the specified PIR server before the HTTP requests can be sent.
    /// To set up the PIR server for URL filtering, it must contain a PIR use case with the following name format:
    /// "<App bundle identifier>.url.filtering".
    /// Your URL data set contains URLs you want to block.  All URLs in the data set must be already puny-coded
    /// before construction of the PIR database.
    ///
    public var pirServerURL: URL? { get }

    /// URL containing the domain name of Privacy Pass Issuer.
    public var pirPrivacyPassIssuerURL: URL? { get }

    /// PIR per-user authentication token string.  An HTTP bearer token that authenticates the person using your app. The system uses this token to
    /// attest that it is a valid user when requesting anonymous authentication tokens.
    public var pirAuthenticationToken: String? { get }

    /// Set an URL filter configuration with the required PIR server attributes as well as App extension information.
    /// - Parameters:
    ///   - pirServerURL: PIR server URL.  The URL must contain only the domain name of the PIR server.
    ///   - pirPrivacyPassIssuer: PIR Privacy Pass Issuer URL.  The URL must contain only the domain name of the Privacy Pass Issuer.
    ///   If nil, PIR server URL will be used as Privacy Pass Issuer URL.
    ///   - pirAuthenticationToken: An HTTP bearer token that authenticates the person using your app. The system uses this token to
    ///   attest that it is a valid user when requesting anonymous authentication tokens.
    ///   - controlProviderBundleIdentifier: Bundle Identifier of the NEURLFilterControlProvider app extension.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    public func setConfiguration(pirServerURL: URL, pirPrivacyPassIssuerURL: URL?, pirAuthenticationToken: String, controlProviderBundleIdentifier: String) throws

    /// This function loads the current URL filter configuration from the caller's URL filter preferences.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    public func loadFromPreferences() async throws

    /// This function saves the URL filter configuration in the caller's URL filter preferences. If the URL filter is enabled, it will become active.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    public func saveToPreferences() async throws

    /// This function removes the URL filter configuration from the caller's URL filter preferences. If the URL filter is enabled, the URL filter becomes disabled.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    public func removeFromPreferences() async throws

    /// The function resets the PIR on-device cache.  The PIR system on device caches previous PIR queries and responses to minimize
    /// exchanges with the PIR server.  When there is a dataset change on the PIR server, a reset of the on-device cache may be needed
    /// to avoid using stale cache entries.
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    public func resetPIRCache() async throws

    /// This function refetches PIR parameters from the server.  In most cases, an explicit refetch is not necessary since PIR system on device
    /// refetches PIR parameters from server periodically to stay up-to-update with the server side.  However, in case of a significant server
    /// database change, PIR parameters may change.  In this case, an explicit trigger of a refetch may be desirable to make the new set of PIR
    /// parameters effective immediately.
    ///
    /// Things that can cause PIR parameters to change:
    /// re-processing the dataset
    /// change of shard count
    /// change of encryption parameters
    /// change of per shard cuckoo hash table size (note: per shard entry count can change, while the cuckoo hash table stays fixed size)
    /// change of cuckoo hashing parameters
    /// - throws
    ///   - Error : returns optional error to indicate the fail reason.
    public func refreshPIRParameters() async throws

    /// Current status of the URL filter.
    public var status: NEURLFilterManager.Status { get async }

    /// This method observes the NEURLFilterStatusDidChange notification and returns an AsyncSequence that yields the new status every time the notification is posted.
    /// Use this method to watch for status change and react to it.
    /// - Parameters:
    ///       - Status: the latest status will be returned at every status change.
    public func handleStatusChange() -> any AsyncSequence<NEURLFilterManager.Status, Never>

    /// This method observes the NEURLFilterConfigurationDidChange notification and returns an AsyncSequence that yields true every time the notification is posted.
    /// Use this method to watch for configuration change and react to it.
    /// - Parameters:
    ///       - Bool: true will be returned at every configuration change.
    public func handleConfigChange() -> any AsyncSequence<Bool, Never>

    /// Retrieve the most recent error that caused the URL Filter to stop.  The returned error will be one of the NEURLFilterManager.Error.
    public var lastDisconnectError: NEURLFilterManager.Error? { get async }
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterManager.Status : Equatable {
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterManager.Status : Hashable {
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterManager.Status : RawRepresentable {
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterManager.Error : Equatable {
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterManager.Error : Hashable {
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilterManager.Error : RawRepresentable {
}

/// A struct containing a prefilter returned by fetchPrefilter() implementation.  NEURLFilterPrefilter must contain a Bloom filter built
/// with the 32-bit FNV-1a and 32-bit MurmurHash3 hash functions, with double hashing.  See fetchPrefilter() documentation.
/// Depending on the size of the Bloom Filter data, it can be passed as Data or the path of a file containing the data.
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
public struct NEURLFilterPrefilter {

    /// Prefilter data type
    public enum PrefilterData {

        /// Data containing the prefilter data
        case smallFilter(Data)

        /// Temporary file path to prefilter data
        case temporaryFilepath(URL)
    }

    /// The tag of the Bloom filter data, (e.g. the SHA-256 hash of the Bloom filter data)
    public let tag: String

    /// Bloom filter data
    public let data: NEURLFilterPrefilter.PrefilterData

    /// number of bits in Bloom filter
    public let bitCount: Int

    /// number of hashes for Bloom filter
    public let hashCount: Int

    /// seed used in MurmurHash3
    public let murmurSeed: UInt32

    /// Initialize a new NEURLFilterPrefilter struct
    /// - Parameters
    ///     - data: data of type PrefilterData, either as Data or a file path to the data
    ///     - tag: The tag of the Bloom filter data, (e.g. the SHA-256 hash of the Bloom filter data)
    ///     - bitCount: number of bits in Bloom filter
    ///     - hashCount: number of hashes for Bloom filter
    ///     - murmurSeed:  seed used in MurmurHash3
    public init(data: NEURLFilterPrefilter.PrefilterData, tag: String, bitCount: Int, hashCount: Int, murmurSeed: UInt32)
}

@available(macOS 15.0, *)
@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension NENetworkRule {

    /// Create a NENetworkRule object that matches network traffic destined for a host within a specific network.
    /// - Parameters:
    ///   - networkEndpoint: An endpoint that contains the port and address or network that the rule matches. This endpoint must contain an address, not a hostname.
    ///     If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all destinations except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port destined for the given address or network.
    ///   - destinationPrefix: An integer that in combination with the address in the endpoint specifies the destination network that the rule matches.
    ///   - protocol: A NENetworkRule.Protocol value indicating the protocol that the rule matches.
    public convenience init(destinationNetworkEndpoint networkEndpoint: NWEndpoint, prefix destinationPrefix: Int, protocol: NENetworkRule.`Protocol`)

    /// Create a NENetworkRule object that matches network traffic destined for a host within a specific DNS domain.
    /// - Parameters:
    ///   - hostEndpoint: An endpoint that contains the port and hostname or domain that the rule matches. This endpoint must contain a hostname, not an address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port destined for the given hostname or domain.
    ///     If the hostname string of the endpoint consists of a single label, then the rule will match traffic destined to the specific host with that single label as its name.
    ///     If the hostname string of the endpoint consists of 2 or more labels, then the rule will match traffic destined to hosts within the domain specified by the hostname string.
    ///   - protocol: A NENetworkRule.Protocol value indicating the protocol that the rule matches.
    ///
    /// ```
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "com", port: 0), protocol: .any) // matches all TCP and UDP traffic to the host named "com".
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "example.com", port: 0), protocol: .any) // matches all TCP and UDP traffic to hosts in the "example.com" DNS domain, including all DNS queries for names in the example.com DNS domain.
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "example.com", port: 53), protocol: .any) // matches all DNS queries/responses for hosts in the "example.com" domain.
    /// NENetworkRule(destinationHostEndpoint: .hostPort(host: "example.com", port: 443), protocol: .TCP) // matches all TCP port 443 traffic to hosts in the "example.com" domain.
    /// ```
    public convenience init(destinationHostEndpoint hostEndpoint: NWEndpoint, protocol: NENetworkRule.`Protocol`)

    /// Create a NENetworkRule object that matches traffic by remote network, local network, protocol, and direction.
    ///
    /// If both remoteNetworkEndpoint and localNetworkEndpoint are nil then the rule will match all traffic of the given protocol and direction, except for loopback traffic. To match loopback traffic create a NENetworkRule with remoteNetworkEndpoint and/or localNetworkEndpoint properties that explicitly match traffic to the loopback address (127.0.0.1 or ::1).
    /// - Parameters:
    ///   - remoteNetworkEndpoint: An endpoint that contains the remote port and the remote address or network that the rule matches. This endpoint must contain an address, not a hostname.
    ///     If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all destinations except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port coming from the remote network.
    ///     Pass nil to cause the rule to match any remote network.
    ///   - remotePrefix: An integer that in combination with the address in remoteNetworkEndpoint specifies the remote network that the rule matches.
    ///   - localNetworkEndpoint: An endpoint that contains the local port and the local address or network that the rule matches. This endpoint must contain an address, not a hostname.
    ///     If the address is a wildcard address (0.0.0.0 or ::) then the rule will match all local networks except for loopback (127.0.0.1 or ::1). To match loopback traffic set the address to the loopback address.
    ///     If the port of the endpoint is 0, then the rule will match traffic on any port coming from the local network.
    ///     Pass nil to cause the rule to match any local network.
    ///   - localPrefix: An integer that in combination with the address in localNetworkEndpoint specifies the local network that the rule matches. This parameter is ignored if localNetworkEndpoint is nil.
    ///   - protocol: A NENetworkRule.Protocol value indicating the protocol that the rule matches.
    ///   - direction: A NETrafficDirection value indicating the direction of network traffic that the rule matches.
    public convenience init(remoteNetworkEndpoint: NWEndpoint?, remotePrefix: Int, localNetworkEndpoint: NWEndpoint?, localPrefix: Int, protocol: NENetworkRule.`Protocol`, direction: NETrafficDirection)

    /// The remote endpoint that the rule matches.
    public var matchRemoteHostOrNetworkEndpoint: NWEndpoint? { get }

    /// The local network that the rule matches.
    public var matchLocalNetworkEndpoint: NWEndpoint? { get }
}

@available(macOS 15.0, *)
@available(iOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
@available(visionOS, unavailable)
extension NEFilterPacketProvider {

    /// A closure to be set to handle each packet received or to be sent. A verdict to allow, drop or delay must be returned to indicate the treatment of the packet.
    ///
    /// Since there may be multiple filtering sources presenting frames to the provider, this packet handler may be executed by multiple simultaneous threads. This packet handler must be able to handle execution in a multi-threaded environment.
    public var handler: ((NEFilterPacketContext, NWInterface, NETrafficDirection, UnsafeRawBufferPointer) -> NEFilterPacketProvider.Verdict)?
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEAppProxyTCPFlow {

    /// An NWEndpoint containing information about the intended remote endpoint of the flow.
    public var remoteFlowEndpoint: NWEndpoint { get }
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEFilterSocketFlow {

    /// The flow's remote endpoint.
    ///
    /// This endpoint may be nil when `NEFilterDataProvider.handleNewFlow(_:)` is invoked and if so will be populated upon receiving network data.
    /// In such a case, filtering on the flow may still be performed based on its socket type, socket family or socket protocol.
    public var remoteFlowEndpoint: NWEndpoint? { get }

    /// The flow's local endpoint.
    ///
    /// This endpoint may be nil when `NEFilterDataProvider.handleNewFlow(_:)` is invoked and if so will be populated upon receiving network data.
    /// In such a case, filtering on the flow may still be performed based on its socket type, socket family or socket protocol.
    public var localFlowEndpoint: NWEndpoint? { get }
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEAppProxyUDPFlow {

    /// Read datagrams from the flow.
    /// - Parameter completionHandler: A closure that will be executed when datagrams have been read from the flow. The closure takes the datagrams that were read, the destination endpoints of the datagrams, and an Error. If an error occurred while reading then the error parameter will be non-nil.
    public func readDatagrams(completionHandler: @escaping ([(Data, NWEndpoint)]?, (any Error)?) -> Void)

    /// Read datagrams from the flow.
    /// - Returns: Datagrams that were read, the destination endpoints of the datagrams, and an Error. If an error occurred while reading then the error element will be non-nil.
    public func readDatagrams() async -> ([(Data, NWEndpoint)]?, (any Error)?)

    /// Write datagrams to the flow.
    /// - Parameters:
    ///   - array: Datagrams to be written, and the source endpoints of the datagrams.
    ///   - completionHandler: A closure that will be executed when the datagrams have been written to the corresponding socket's receive buffer.
    public func writeDatagrams(_ array: [(Data, NWEndpoint)], completionHandler: @escaping ((any Error)?) -> Void)

    /// Write datagrams to the flow.
    /// - Parameter array: Datagrams to be written, and the source endpoints of the datagrams.
    public func writeDatagrams(_ array: [(Data, NWEndpoint)]) async throws

    /// An NWEndpoint containing the local endpoint of the flow's corresponding socket.
    public var localFlowEndpoint: NWEndpoint? { get }
}

/// This file declares the NEURLFilter API.  For Applications that are not using any of the Apple Networking frameworks
/// (WebKit, CFNetwork and Network frameworks), use the NEURLFilter API to voluntarily validate URLs before potentially
/// connecting to any restricted or malicious Internet site.  This API checks the specified URL and returns a Allow or Deny
/// verdict.  Applications should not connect to any URLs with the Deny result.
/// This API is part of NetworkExtension.framework.
@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NEURLFilter {

    /// This method determines if the specified URL should be allowed or denied.  The returned Allow or Deny verdict should be honored to prevent
    /// communication with restricted or malicious Internet sites.
    /// - Parameters:
    ///   - url: url to be validated
    /// - Returns
    ///   - NEURLFilter.Verdict: A NEURLFilter.Verdict will be returned to indicate whether the specified URL should be allowed or denied.  If verdict is
    ///   Deny, caller should fail the URL request.
    public class func verdict(for url: URL) async -> NEURLFilter.Verdict
}

@available(iOS 26.0, macOS 26.0, *)
@available(watchOS, unavailable)
@available(visionOS, unavailable)
@available(tvOS, unavailable)
extension NSNotification.Name {

    /// Name of the NSNotification that is posted when the URL filter configuration changes.
    public static let NEURLFilterConfigurationDidChange: Notification.Name

    /// Name of the NSNotification that is posted when the URL filter status changes.
    public static let NEURLFilterStatusDidChange: Notification.Name
}

@available(macOS 15.0, iOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
extension NEAppProxyFlow {

    /// This function is used by an NEProvider implementation to indicate that it is ready to handle flow data.
    /// - Parameters:
    ///   - localEndpoint: The address and port that should be used as the local endpoint of the socket associated with this flow. If the source application already specified a local endpoint by binding the socket then this parameter is ignored.
    ///   - completionHandler: A block that is called when the process of opening flow is complete. A nil value passed to this block indicates that the flow was opened successfully. A non-nil NSError value indicates that the flow failed to open successfully.
    public func open(withLocalFlowEndpoint localEndpoint: NWEndpoint?, completionHandler: @escaping ((any Error)?) -> Void)

    /// This function is used by an NEProvider implementation to indicate that it is ready to handle flow data.
    /// - Parameter localEndpoint: The address and port that should be used as the local endpoint of the socket associated with this flow. If the source application already specified a local endpoint by binding the socket then this parameter is ignored.
    public func open(withLocalFlowEndpoint localEndpoint: NWEndpoint?) async throws

    /// Set the flow's NEFlowMetaData object in an NWParameters object. The NWParameters object can then be used to create a connection that transparently proxies the flow's data, and provides accurate source app information to any subsequent NEAppProxyProvider instances that transparently proxy the flow.
    /// - Parameter parameters: An NWParameters object.
    public func setMetadata(on parameters: NWParameters)

    /// An NWInterface containing information about the network interface used by the flow.
    ///
    /// If the flow's data is transported using a different interface, this property should be set to that interface.
    public var interface: NWInterface?
}

@available(macOS 26.0, iOS 26.0, tvOS 26.0, *)
@available(watchOS, unavailable)
extension NEVPNIKEv2SecurityAssociationParameters {

    /// The post-quantum key exchange method(s) used by the Security Association, if any.
    ///
    /// Up to 7 methods may be specified, mapping to ADDKE1 - ADDKE7 from RFC 9370.
    public var postQuantumKeyExchangeMethods: [NEVPNIKEv2PostQuantumKeyExchangeMethod]
}

@available(macOS 15.0, iOS 18.0, tvOS 18.0, visionOS 2.0, *)
@available(watchOS, unavailable)
extension NEPacketTunnelProvider {

    /// The virtual network interface used to route packets to the packet tunnel provider.
    ///
    /// For NEPacketTunnelProvider sub-classes, this property will be non-nil when `NEPacketTunnelProvider.startTunnel(options:)` is called. For NEEthernetTunnelProvider sub-classes, this property will be non-nil after `NETunnelProvider.setTunnelNetworkSettings(_:)` returns. To create a connection through the tunnel, set this interface as `NWParameters.requiredInterface`.
    public var virtualInterface: NWInterface? { get }
}

prefix operator >>
