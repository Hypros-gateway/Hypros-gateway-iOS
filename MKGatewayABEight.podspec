#
# Be sure to run `pod lib lint MKGatewayABEight.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKGatewayABEight'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKGatewayABEight.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lovexiaoxia/MKGatewayABEight'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/lovexiaoxia/MKGatewayABEight.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  
  s.resource_bundles = {
    'MKGatewayABEight' => ['MKGatewayABEight/Assets/*.png']
  }
  
  s.subspec 'Expand' do |ss|
    
    ss.subspec 'DatabaseManager' do |sss|
      sss.source_files = 'MKGatewayABEight/Classes/Expand/DatabaseManager/**'
      
      sss.dependency 'FMDB'
    end
    
    ss.subspec 'BaseController' do |sss|
      sss.source_files = 'MKGatewayABEight/Classes/Expand/BaseController/**'
    end
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKGatewayABEight/DeviceModel'
    ss.dependency 'MKCustomUIModule'
    
  end
  
  s.subspec 'DeviceModel' do |ss|
    ss.source_files = 'MKGatewayABEight/Classes/DeviceModel/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKGatewayABEight/SDK/MQTT'
  end
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKGatewayABEight/Classes/CTMediator/**'
      
    ss.dependency 'CTMediator'
    
    ss.dependency 'MKGatewayABEight/DeviceModel'
  end
  
  s.subspec 'SDK' do |ss|
  
    ss.subspec 'BLE' do |sss|
      sss.source_files = 'MKGatewayABEight/Classes/SDK/BLE/**'
      
      sss.dependency 'MKBaseBleModule'
    end
    
    ss.subspec 'MQTT' do |sss|
      sss.source_files = 'MKGatewayABEight/Classes/SDK/MQTT/**'
      
      ss.dependency 'MKBaseModuleLibrary'
      ss.dependency 'MKBaseMQTTModule'
    end
  
  end
  
  
  s.subspec 'Modules' do |ss|
    
    ss.subspec 'FunctionModule' do |sss|
        sss.subspec 'SDK' do |ssss|
          ssss.subspec 'MQTT' do |sssss|
            sssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/SDK/MQTT/**'
          end
        end
        sss.subspec 'Target' do |ssss|
          ssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Target/**'
          
          ssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions'
        end
        sss.subspec 'Functions' do |ssss|
          
          ssss.subspec 'AdvBeaconPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/AdvBeaconPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/AdvBeaconPage/Model'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/AdvBeaconPage/View'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/AdvBeaconPage/Model/**'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/AdvBeaconPage/View/**'
              end
          end
          
          ssss.subspec 'DeviceDataPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/DeviceDataPage/Controller/**'
                                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/SettingPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/UploadOptionPage/Controller'
              end
          end
          
          ssss.subspec 'DeviceInfoPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/DeviceInfoPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/DeviceInfoPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/DeviceInfoPage/Model/**'
              end
          end
          
          ssss.subspec 'DuplicateDataFilterPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/DuplicateDataFilterPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/DuplicateDataFilterPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/DuplicateDataFilterPage/Model/**'
              end
          end
          
          ssss.subspec 'ModifyMQTTServerPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/ModifyMQTTServerPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/ModifyMQTTServerPage/Model'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/ModifyMQTTServerPage/View'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/ModifyMQTTServerPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/ModifyMQTTServerPage/Model/**'
              end
          end
          
          ssss.subspec 'NTPServerPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/NTPServerPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/NTPServerPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/NTPServerPage/Model/**'
              end
          end
          
          ssss.subspec 'OTAPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/OTAPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/OTAPage/Model'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/OTAPage/View'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/SlaveFileSelectPage/Controller'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/OTAPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/OTAPage/Model/**'
                
                ssssss.dependency 'iOSDFULibrary'
              end
          end
          
          ssss.subspec 'ServerForDevice' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/ServerForDevice/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/ServerForDevice/Model'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/ServerForDevice/View'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/ServerForDevice/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/ServerForDevice/Model/**'
              end
          end
          
          ssss.subspec 'SettingPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/SettingPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/SettingPage/Model'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/AdvBeaconPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/DeviceInfoPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/SystemTimePage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/ModifyMQTTServerPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/OTAPage/Controller'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/SettingPage/Model/**'
              end
          end
          
          ssss.subspec 'SlaveFileSelectPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/SlaveFileSelectPage/Controller/**'
              end
          end
          
          ssss.subspec 'SystemTimePage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/SystemTimePage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/SystemTimePage/View'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/NTPServerPage/Controller'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/SystemTimePage/View/**'
              end
          end
          
          ssss.subspec 'UploadDataOptionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/UploadDataOptionPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/UploadDataOptionPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/UploadDataOptionPage/Model/**'
              end
          end
          
          ssss.subspec 'UploadOptionPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/UploadOptionPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/UploadOptionPage/View'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/UploadOptionPage/Model'
                
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/UploadDataOptionPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/DuplicateDataFilterPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/UploadOptionPage/View/**'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/UploadOptionPage/Model/**'
              end
          end
          
          ssss.subspec 'FilterPages' do |sssss|
            
            sssss.subspec 'FilterByAdvNamePage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByAdvNamePage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByAdvNamePage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByAdvNamePage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByBeaconPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Model'
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Header'
              end
              ssssss.subspec 'Header' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Header/**'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Model/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Header'
              end
            end
            
            sssss.subspec 'FilterByMacPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByMacPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByMacPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByMacPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByOtherPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByOtherPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByOtherPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByOtherPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByRawDataPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByRawDataPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByRawDataPage/Model'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByBeaconPage/Controller'
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByUIDPage/Controller'
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByURLPage/Controller'
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByTLMPage/Controller'
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByOtherPage/Controller'
                
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByRawDataPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByTLMPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByTLMPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByTLMPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByTLMPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByUIDPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByUIDPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByUIDPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByUIDPage/Model/**'
              end
            end
            
            sssss.subspec 'FilterByURLPage' do |ssssss|
              ssssss.subspec 'Controller' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByURLPage/Controller/**'
                
                sssssss.dependency 'MKGatewayABEight/Modules/FunctionModule/Functions/FilterPages/FilterByURLPage/Model'
              end
              ssssss.subspec 'Model' do |sssssss|
                sssssss.source_files = 'MKGatewayABEight/Classes/Modules/FunctionModule/Functions/FilterPages/FilterByURLPage/Model/**'
              end
            end
            
          end
          
          ssss.dependency 'MKGatewayABEight/Modules/CommonModule'
          ssss.dependency 'MKGatewayABEight/Modules/FunctionModule/SDK'
        end
    end
    
    ss.subspec 'MainModule' do |sss|
        sss.subspec 'SDK' do |ssss|
          ssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/SDK/**'
        end
        sss.subspec 'Functions' do |ssss|
          
          ssss.subspec 'DeviceListPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/DeviceListPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/DeviceListPage/View'
                
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ScanPage/Controller'
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ServerForAPP/Controller'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/DeviceListPage/View/**'
              end
          end
          
          ssss.subspec 'ScanPage' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/ScanPage/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ScanPage/View'
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ScanPage/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/ScanPage/Model/**'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/ScanPage/View/**'
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ScanPage/Model'
              end
          end
          
          ssss.subspec 'ServerForAPP' do |sssss|
              sssss.subspec 'Controller' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/ServerForAPP/Controller/**'
                
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ServerForAPP/View'
                ssssss.dependency 'MKGatewayABEight/Modules/MainModule/Functions/ServerForAPP/Model'
              end
              sssss.subspec 'Model' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/ServerForAPP/Model/**'
              end
              sssss.subspec 'View' do |ssssss|
                ssssss.source_files = 'MKGatewayABEight/Classes/Modules/MainModule/Functions/ServerForAPP/View/**'
              end
          end
          
          ssss.dependency 'MKGatewayABEight/Modules/MainModule/SDK'
        end
        sss.dependency 'MKGatewayABEight/Modules/CommonModule'
    end
    
    ss.subspec 'CommonModule' do |sss|
      
      sss.subspec 'Pages' do |ssss|
        
        ssss.subspec 'ConnectionSettingPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/ConnectionSettingPage/Controller/**'
              
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/ConnectionSettingPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/ConnectionSettingPage/Protocol/**'
            end
        end
        
        ssss.subspec 'ConnectSuccessPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/ConnectSuccessPage/Controller/**'
            end
        end
        
        ssss.subspec 'DataReportingPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/DataReportingPage/Controller/**'
              
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/DataReportingPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/DataReportingPage/Protocol/**'
            end
        end
        
        ssss.subspec 'LEDSettingPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/LEDSettingPage/Controller/**'
              
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/LEDSettingPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/LEDSettingPage/Protocol/**'
            end
        end
        
        ssss.subspec 'MQTTSettingForDevicePage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/MQTTSettingForDevicePage/Controller/**'
              
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/MQTTSettingForDevicePage/Protocol'
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/MQTTSettingForDevicePage/View'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/MQTTSettingForDevicePage/Protocol/**'
            end
            sssss.subspec 'View' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/MQTTSettingForDevicePage/View/**'
            end
        end
        
        ssss.subspec 'NetworkStatusPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/NetworkStatusPage/Controller/**'
              
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/NetworkStatusPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/NetworkStatusPage/Protocol/**'
            end
        end
        
        ssss.subspec 'ScanTimeoutOptionPage' do |sssss|
            sssss.subspec 'Controller' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/ScanTimeoutOptionPage/Controller/**'
              
              ssssss.dependency 'MKGatewayABEight/Modules/CommonModule/Pages/ScanTimeoutOptionPage/Protocol'
            end
            sssss.subspec 'Protocol' do |ssssss|
              ssssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Pages/ScanTimeoutOptionPage/Protocol/**'
            end
        end
        
      end
      
      sss.subspec 'Views' do |ssss|
        
        ssss.subspec 'DeviceDataPageView' do |sssss|
          sssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Views/DeviceDataPageView/**'
        end
        
        ssss.subspec 'FilterBeaconCell' do |sssss|
          sssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Views/FilterBeaconCell/**'
        end
        
        ssss.subspec 'FilterByRawDataCell' do |sssss|
          sssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Views/FilterByRawDataCell/**'
        end
        
        ssss.subspec 'FilterEditSectionHeaderView' do |sssss|
          sssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Views/FilterEditSectionHeaderView/**'
        end
        
        ssss.subspec 'FilterNormalTextFieldCell' do |sssss|
          sssss.source_files = 'MKGatewayABEight/Classes/Modules/CommonModule/Views/FilterNormalTextFieldCell/**'
        end
        
      end
    end
    
  
    ss.dependency 'MKGatewayABEight/DeviceModel'
    ss.dependency 'MKGatewayABEight/Expand'
    ss.dependency 'MKGatewayABEight/SDK'
    ss.dependency 'MKGatewayABEight/CTMediator'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MLInputDodger'
  
  end
  
end
