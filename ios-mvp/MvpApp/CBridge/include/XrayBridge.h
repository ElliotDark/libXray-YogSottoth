#ifndef XRAY_BRIDGE_H
#define XRAY_BRIDGE_H

#ifdef __cplusplus
extern "C" {
#endif

char* CGoInitDns(const char* base64Text);
char* CGoResetDns(void);
char* CGoGetFreePorts(int count);
char* CGoConvertShareLinksToXrayJson(const char* base64Text);
char* CGOConvertXrayJsonToShareLinks(const char* base64Text);
char* CGoCountGeoData(const char* base64Text);
char* CGoThinGeoData(const char* base64Text);
char* CGoReadGeoFiles(const char* base64Text);
char* CGoPing(const char* base64Text);
char* CGoQueryStats(const char* base64Text);
char* CGoTestXray(const char* base64Text);
char* CGoRunXray(const char* base64Text);
char* CGoStopXray(void);
char* CGoXrayVersion(void);

#ifdef __cplusplus
}
#endif

#endif /* XRAY_BRIDGE_H */
