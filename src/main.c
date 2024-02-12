#include <windows.h>
#include <winreg.h>

#include <stdio.h>

#include "main.h"

REGISTRY_VALUE* head = (REGISTRY_VALUE*)malloc(sizeof(head));

void listRegistryStrings(const char *registryPath) {
    /*
    @param: path of a registry key relative to the current user
    @return
    */
    HKEY hKey;
    LONG result;

    result = RegOpenKeyEx(HKEY_CURRENT_USER, registryPath, 0, KEY_READ, &hKey);
    if (result != ERROR_SUCCESS) {
        fprintf(stderr, "Error opening registry key: %ld\n", result);
        return;
    }

    printf("String values under registry path '%s':\n", registryPath);
    DWORD index = 0;
    TCHAR valueName[MAX_PATH];
    DWORD valueNameSize = MAX_PATH;
    DWORD valueType;
    BYTE data[MAX_PATH];
    DWORD dataSize = MAX_PATH;

    while (RegEnumValue(hKey, index, valueName, &valueNameSize, NULL, &valueType, data, &dataSize) == ERROR_SUCCESS) {
        if (valueType == REG_SZ) {
            // Check if the value type is REG_SZ (string)
            printf("%s: %s\n", valueName, (char*)data);
        }
        index++;
        valueNameSize = MAX_PATH;
        dataSize = MAX_PATH;
    }

    RegCloseKey(hKey);
}

int main(void) {
    printf("Enumerating persistence methods...\n");

    const char *registryPath = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run";
    listRegistryStrings(registryPath);

    return (0);
}