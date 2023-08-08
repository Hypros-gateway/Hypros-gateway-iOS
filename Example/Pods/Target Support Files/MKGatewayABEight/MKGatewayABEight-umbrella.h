#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CTMediator+MKGAAdd.h"
#import "MKGatewayABModuleKey.h"
#import "MKGADeviceModel.h"
#import "MKGADeviceModeManager.h"
#import "MKGABaseViewController.h"
#import "MKGADeviceDatabaseManager.h"
#import "MKGAConnectSuccessController.h"
#import "MKGAConnectionSettingController.h"
#import "MKGAConnectionSettingPageProtocol.h"
#import "MKGADataReportingController.h"
#import "MKGADataReportPageProtocol.h"
#import "MKGALEDSettingController.h"
#import "MKGALEDSettingPageProtocol.h"
#import "MKGAMQTTSettingForDeviceController.h"
#import "MKGAMQTTSettingForDevicePageProtocol.h"
#import "MKGAMQTTSettingForDeviceCell.h"
#import "MKGANetworkStatusController.h"
#import "MKGANetworkStatusPageProtocol.h"
#import "MKGAScanTimeoutOptionController.h"
#import "MKGAScanTimeoutOptionPageProtocol.h"
#import "MKGADeviceDataPageCell.h"
#import "MKGADeviceDataTableHeaderView.h"
#import "MKGAFilterBeaconCell.h"
#import "MKGAFilterByRawDataCell.h"
#import "MKGAFilterEditSectionHeaderView.h"
#import "MKGAFilterNormalTextFieldCell.h"
#import "MKGAAdvBeaconController.h"
#import "MKGAAdvBeaconModel.h"
#import "MKGAAdvBeaconTxPowerCell.h"
#import "MKGADeviceDataController.h"
#import "MKGADeviceInfoController.h"
#import "MKGADeviceInfoModel.h"
#import "MKGADuplicateDataFilterController.h"
#import "MKGADuplicateDataFilterModel.h"
#import "MKGAFilterByAdvNameController.h"
#import "MKGAFilterByAdvNameModel.h"
#import "MKGAFilterByBeaconController.h"
#import "MKGAFilterByBeaconDefines.h"
#import "MKGAFilterByBeaconModel.h"
#import "MKGAFilterByMacController.h"
#import "MKGAFilterByMacModel.h"
#import "MKGAFilterByOtherController.h"
#import "MKGAFilterByOtherModel.h"
#import "MKGAFilterByRawDataController.h"
#import "MKGAFilterByRawDataModel.h"
#import "MKGAFilterByTLMController.h"
#import "MKGAFilterByTLMModel.h"
#import "MKGAFilterByUIDController.h"
#import "MKGAFilterByUIDModel.h"
#import "MKGAFilterByURLController.h"
#import "MKGAFilterByURLModel.h"
#import "MKGAModifyServerController.h"
#import "MKGAModifyServerModel.h"
#import "MKGAModifyServerFooterView.h"
#import "MKGAModifyServerSettingView.h"
#import "MKGAModifyServerSSLTextField.h"
#import "MKGAModifyServerSSLView.h"
#import "MKGANTPServerController.h"
#import "MKGANTPServerModel.h"
#import "MKGAOTAController.h"
#import "MKGADFUModel.h"
#import "MKGAOTADataModel.h"
#import "MKGADFUFileCell.h"
#import "MKGAServerForDeviceController.h"
#import "MKGAServerForDeviceModel.h"
#import "MKGAMQTTSSLForDeviceView.h"
#import "MKGAServerConfigDeviceFooterView.h"
#import "MKGAServerConfigDeviceSettingView.h"
#import "MKGAWifiAlertView.h"
#import "MKGASettingController.h"
#import "MKGASettingsProtocolModel.h"
#import "MKGASlaveFileSelectController.h"
#import "MKGASystemTimeController.h"
#import "MKGASystemTimeCell.h"
#import "MKGAUploadDataOptionController.h"
#import "MKGAUploadDataOptionModel.h"
#import "MKGAUploadOptionController.h"
#import "MKGAUploadOptionModel.h"
#import "MKGAFilterCell.h"
#import "MKGAMQTTConfigDefines.h"
#import "MKGAMQTTInterface.h"
#import "MKGAMQTTManager.h"
#import "MKGAMQTTOperation.h"
#import "MKGAMQTTTaskAdopter.h"
#import "MKGAMQTTTaskID.h"
#import "Target_Gateway_AB_Module.h"
#import "MKGADeviceListController.h"
#import "MKGAAddDeviceView.h"
#import "MKGADeviceListCell.h"
#import "MKGAEasyShowView.h"
#import "MKGAScanPageController.h"
#import "MKGAScanPageModel.h"
#import "MKGAScanPageCell.h"
#import "MKGAServerForAppController.h"
#import "MKGAServerForAppModel.h"
#import "MKGAMQTTSSLForAppView.h"
#import "MKGAServerConfigAppFooterView.h"
#import "MKGAMMQTTManager.h"
#import "CBPeripheral+MKGAAdd.h"
#import "MKGABLESDK.h"
#import "MKGACentralManager.h"
#import "MKGAInterface+MKGAConfig.h"
#import "MKGAInterface.h"
#import "MKGAOperation.h"
#import "MKGAOperationID.h"
#import "MKGAPeripheral.h"
#import "MKGATaskAdopter.h"
#import "MKGAMQTTServerManager.h"
#import "MKGAServerConfigDefines.h"
#import "MKGAServerParamsModel.h"

FOUNDATION_EXPORT double MKGatewayABEightVersionNumber;
FOUNDATION_EXPORT const unsigned char MKGatewayABEightVersionString[];

