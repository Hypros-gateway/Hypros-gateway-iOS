

typedef NS_ENUM(NSInteger, mk_ga_taskOperationID) {
    mk_ga_defaultTaskOperationID,
    
#pragma mark - Read
    mk_ga_taskReadFirmwareOperation,           //读取固件版本
    mk_ga_taskReadHardwareOperation,           //读取硬件类型
    mk_ga_taskReadDeviceNameOperation,         //读取设备名称
    
#pragma mark - 自定义协议读取
    mk_ga_taskReadWIFISSIDOperation,            //读取设备当前的wifi ssid
    mk_ga_taskReadWIFIPasswordOperation,        //读取设备当前的wifi密码
    mk_ga_taskReadConnectModeOperation,         //读取MTQQ服务器通信加密方式
    mk_ga_taskReadServerHostOperation,          //读取MQTT服务器域名
    mk_ga_taskReadServerPortOperation,          //读取MQTT服务器端口
    mk_ga_taskReadServerCleanSessionOperation,  //读取MQTT Clean Session
    mk_ga_taskReadServerKeepAliveOperation,     //读取MQTT KeepAlive
    mk_ga_taskReadServerQosOperation,           //读取MQTT Qos
    mk_ga_taskReadClientIDOperation,            //读取Client ID
    mk_ga_taskReadDeviceIDOperation,            //读取Device ID
    mk_ga_taskReadSubscibeTopicOperation,       //读取Subscribe topic
    mk_ga_taskReadPublishTopicOperation,        //读取Publish topic
    mk_ga_taskReadNTPServerHostOperation,       //读取NTP服务器域名
    mk_ga_taskReadDeviceMacAddressOperation,    //读取Mca地址
    mk_ga_taskReadDeviceTypeOperation,          //读取设备类型
    mk_ga_taskReadTimeZoneOperation,            //读取时区
    mk_ga_taskReadChannelOperation,              //读取区域参数
    mk_ga_taskReadServerUserNameOperation,      //读取服务器登录用户名
    mk_ga_taskReadServerPasswordOperation,      //读取服务器登录密码
        
#pragma mark - 密码特征
    mk_ga_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 配置
    mk_ga_taskExitConfigModeOperation,          //设备退出配置模式
    mk_ga_taskConfigWIFISSIDOperation,          //配置wifi的ssid
    mk_ga_taskConfigWIFIPasswordOperation,      //配置wifi的密码
    mk_ga_taskConfigConnectModeOperation,       //配置MTQQ服务器通信加密方式
    mk_ga_taskConfigServerHostOperation,        //配置MQTT服务器域名
    mk_ga_taskConfigServerPortOperation,        //配置MQTT服务器端口
    mk_ga_taskConfigServerCleanSessionOperation,    //配置MQTT Clean Session
    mk_ga_taskConfigServerKeepAliveOperation,       //配置MQTT KeepAlive
    mk_ga_taskConfigServerQosOperation,             //配置MQTT Qos
    mk_ga_taskConfigClientIDOperation,              //配置ClientID
    mk_ga_taskConfigDeviceIDOperation,              //配置DeviceID
    mk_ga_taskConfigSubscibeTopicOperation,         //配置Subscribe topic
    mk_ga_taskConfigPublishTopicOperation,          //配置Publish topic
    mk_ga_taskConfigNTPServerHostOperation,         //配置NTP服务器域名
    mk_ga_taskConfigTimeZoneOperation,              //配置时区
    mk_ga_taskConfigChannelOperation,               //配置MK107D Pro的区域参数
    
    mk_ga_taskConfigServerUserNameOperation,        //配置服务器的登录用户名
    mk_ga_taskConfigServerPasswordOperation,        //配置服务器的登录密码
    mk_ga_taskConfigCAFileOperation,                //配置CA证书
    mk_ga_taskConfigClientCertOperation,            //配置设备证书
    mk_ga_taskConfigClientPrivateKeyOperation,      //配置私钥
};

