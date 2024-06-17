#include "okFrontPanel.h"
#include <iostream>
namespace ok = OpalKelly;

int main(int argc, char *argv[]) {

  if (argc == 1) {
    std::cout << "USAGE: ./load_bitsream file.bit\n";
    return 1;
  }

  ok::FrontPanelDevices devices;
  // Opens the first connected device (no serial # argument)
  ok::FrontPanelPtr fp = devices.Open();
  okCFrontPanel::ErrorCode error;
  if (fp) {
    okTDeviceInfo* info = new okTDeviceInfo;
    fp->GetDeviceInfo(info);
    std::cout << "Loading " << info->productName << "-" << info->usbSpeed <<  "\n";
    delete info;
    error = fp->ConfigureFPGA(argv[1]);
    if (error) {
      std::cout << "Error: " << error << std::endl;
    }
    fp->Close();
  } else {
    std::cout << "No device available\n";
  }
}
