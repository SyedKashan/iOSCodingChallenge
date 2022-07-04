//
//  ApiManager.swift
//  CodingChallenge
//
//  Created by Syed Ali Kashan on 05/07/2022.
//

import Foundation
import UIKit
import SystemConfiguration

/*
 API manager that handles all the api related work and parses the data based on the model
 provided while making a call.
*/

enum CompletionResponse {
	case success
	case failure(errorMessage: String?, errorDetails: String?)
}

/*========================================================================*/

public class ApiManager<T> where T: Codable {
	
	private let successHandler: (T) -> Void
	private let nullDataSuccessHandler: ((HttpStatusCode) -> Void)?
	private let errorHandler: (_ statusCode: HttpStatusCode?, _ dataDictionary: [String: Any]?) -> Void
	
	let apiClient = APIClient()
	let baseUrl = NetworkConstants.getBaseUrl()
	
	var task: URLSessionDataTask!
	var showLoader = false
	let viewBGLoder: UIView = UIView()
	var spinner: UIActivityIndicatorView!
	var showError = true
	var saveSuccessMessage = true
	
	init(successHandler: @escaping (T) -> Void,
		 nullDataSuccessHandler: ((HttpStatusCode) -> Void)? = nil,
		 errorHandler: @escaping (_ statusCode: HttpStatusCode?, _ dataDictionary: [String: Any]?) -> Void) {
		
		self.successHandler = successHandler
		self.nullDataSuccessHandler = nullDataSuccessHandler
		self.errorHandler = errorHandler
	}
}

/*========================================================================*/

extension ApiManager {
	
	private func handleSucessResponse(data: T?) {
		guard let data = data else {
			guard let handler = self.nullDataSuccessHandler else {
				// MARK: Unknown Error Handler
				self.showErrorIfAllowed(error: "something_wrong".localized)
				self.errorHandler(nil, nil)
				return
			}
			handler(HttpStatusCode.success)
			return
		}
		
		// MARK: Success From Server
		self.successHandler(data)
	}
}

/*========================================================================*/
extension ApiManager {
	
	private func showLoadingIndicator() {
		hideLoadingIndicator()
		viewBGLoder.frame = UIScreen.main.bounds
		viewBGLoder.backgroundColor = UIColor.white.withAlphaComponent(0.6)
		viewBGLoder.tag = 1307966

		let originX = UIScreen.main.bounds.width/2
		let originY = UIScreen.main.bounds.height/2

		let loaderView = CGRect(x: originX - 50/2, y: originY - 50/2, width: 50, height: 50)
		spinner = UIActivityIndicatorView(style: .large)
		spinner.frame = loaderView
		spinner.color = .black
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.startAnimating()
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
			guard let self = self else {return}
			UIViewController.top().view.addSubview(self.viewBGLoder)
			self.viewBGLoder.addSubview(self.spinner)
		}
	}
	
	private func hideLoadingIndicator() {
		guard let spinner = spinner else {return}
		spinner.removeFromSuperview()
		self.viewBGLoder.removeFromSuperview()
		UIViewController.top().view.viewWithTag(1307966)?.removeFromSuperview()
	}
	
	private func makeNetworkCall(with urlRequest: URLRequest) -> URLSessionDataTask {
		self.showLoader ? self.showLoadingIndicator() : ()
		task?.cancel()
		
		task = self.apiClient.dataTask(urlRequest) { response in
			// Response
			DispatchQueue.main.async {
				self.showLoader ? self.hideLoadingIndicator() : ()
			}
			switch response {
			case .success(let serverResponse):
				
				print(serverResponse.response)
				
				if let jsonString = String(data: serverResponse.data, encoding: .utf8) {
					print("FOR DEBUGGING RAW JSON REPONSE")
					print(jsonString)
				}
				
				do {
					let decoder = JSONDecoder()
					let apiResponse = try decoder.decode(ApiResponse<T>.self, from: serverResponse.data)
					
					let statusCode = serverResponse.response.statusCode.status
					switch statusCode {
					case .success:
						self.handleSucessResponse(data: apiResponse.data)
						
					case .validation:
						// MARK: Server Validation Errors
						if let dataDictionary = serverResponse.data.getJSONFromData() {
							self.errorHandler(.validation, dataDictionary)
						} else {
							self.errorHandler(nil, nil)
						}
					case .failure:
						if let dataDictionary = serverResponse.data.getJSONFromData() {
							self.errorHandler(.validation, dataDictionary)
						} else {
							self.errorHandler(nil, nil)
						}
					case .unauthorized:
						// MARK: Unauthorized User
						self.errorHandler(nil, nil)
						self.logoutUser()
					case .serverError, .unknown:
						// MARK: Unknown Error Handler
						self.showErrorIfAllowed(error: "something_wrong".localized)
						self.errorHandler(nil, nil)
					}
				} catch let error {
					// MARK: JSON Parsing Error
					print(error.localizedDescription)
					self.showErrorIfAllowed(error: "something_wrong".localized)
					self.errorHandler(nil, nil)
				}
			case .failure(let error):
				// MARK: Unknown Error Handler
				print(error)
				// FIXME: create popup for no internet
				// show alert for no internet
				self.errorHandler(nil, nil)
			}
		}
		return task
	}
}

/*========================================================================*/
extension ApiManager {
	
	@discardableResult func makeNetworkCall(for method: ApiEndPoints? = nil,
											endPointUrl: String? = nil,
											with parameter: Any?,
											requestType: URLRequest.HTTPMethod,
											withLoader isLoader: Bool = false,
											showErrorMessages: Bool = true,
											saveSuccessMessage: Bool = true) -> URLSessionDataTask? {
		self.showLoader = isLoader
		self.showError = showErrorMessages
		self.saveSuccessMessage = saveSuccessMessage
		
		var url = String()
		
		if let endPointName = method {
			url = self.baseUrl + endPointName.methodName
		} else if let endPointUrl = endPointUrl {
			url = endPointUrl
		}
		
		let urlRequest = URLRequest(url: url,
									method: requestType,
									header: getApiHeaders(),
									body: parameter)
		
		return (self.makeNetworkCall(with: urlRequest))
	}
}

/*========================================================================*/
extension ApiManager {
	
	func showErrorIfAllowed(error: String) {
		if self.showError {
		}
	}
	
	// MARK: Unauthorized User
	func logoutUser() {
	}
}

/*========================================================================*/

extension ApiManager {
	
	func getApiHeaders() -> [String: String] {
		
		var headers = [String: String]()
		
		headers["Content-Type"] = "application/json"
		headers["Accept"] = "application/json"
		headers["x-device-type"] = "ios"
		headers["device"] = "ios"
		headers["x-os-version"] = "\(UIDevice.current.systemVersion)"
				
		return headers
	}
	
	func isInternetAvailable() -> Bool {
		var zeroAddress = sockaddr_in()
		zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
		zeroAddress.sin_family = sa_family_t(AF_INET)
		
		let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
			$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
				SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
			}
		}
		
		var flags = SCNetworkReachabilityFlags()
		if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
			return false
		}
		let isReachable = flags.contains(.reachable)
		let needsConnection = flags.contains(.connectionRequired)
		return (isReachable && !needsConnection)
	}
}
