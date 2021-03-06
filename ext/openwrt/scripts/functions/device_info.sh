#!/bin/sh
# Copyright (C) 2012-2014 PIVA Software <www.pivasoftware.com>
# 	Author: MOHAMED Kallel <mohamed.kallel@pivasoftware.com>
# 	Author: AHMED Zribi <ahmed.zribi@pivasoftware.com>
# Copyright (C) 2011-2012 Luka Perkov <freecwmp@lukaperkov.net>

get_device_info_specversion() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.SpecVersion"
local permissions="0"
case "$action" in
	get_value)
	val="1.0"
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_provisioningcode() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.ProvisioningCode"
local permissions="1"
case "$action" in
	get_value)
	easycwmp_get_parameter_value "val" "$param"
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

set_device_info_provisioningcode() {
local val=$1
local param="InternetGatewayDevice.DeviceInfo.ProvisioningCode"
case "$action" in
	set_value)
	easycwmp_set_parameter_value "$param" "$val"
	;;
	set_notification)
	easycwmp_set_parameter_notification "$param" "$val"
	;;
esac
}

get_device_info_manufacturer() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.Manufacturer"
local permissions="0"
case "$action" in
	get_value)
	val=`cat /tmp/sysinfo/model | cut -d' ' -f1`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_oui() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.ManufacturerOUI"
local permissions="0"
case "$action" in
	get_value)
	val=`uci get wireless.radio0.macaddr | tr 'a-f' 'A-F' | tr -d ':' | cut -c 1-6`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_product_class() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.ProductClass"
local permissions="0"
case "$action" in
	get_value)
	val=`cat /tmp/sysinfo/board_name`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_serial_number() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.SerialNumber"
local permissions="0"
case "$action" in
	get_value)
	local val=`uci get wireless.radio0.macaddr | tr 'a-f' 'A-F' | tr -d ':'`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_hardware_version() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.HardwareVersion"
local permissions="0"
case "$action" in
	get_value)
	val=`cat /tmp/sysinfo/model`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_software_version() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.SoftwareVersion"
local permissions="0"
case "$action" in
	get_value)
	val="openwrt-`cat /etc/openwrt_version`"
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_uptime() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.UpTime"
local permissions="0"
case "$action" in
	get_value)
	val=`cat /proc/uptime | awk -F "." '{ print $1 }'`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_device_log() {
local nl="$1"
local val=""
local param="InternetGatewayDevice.DeviceInfo.DeviceLog"
local permissions="0"
case "$action" in
	get_value)
	val=`logread | tail -10`
	;;
	get_name)
	[ "$nl" = "1" ] && return $E_INVALID_ARGUMENTS
	;;
	get_notification)
	easycwmp_get_parameter_notification "val" "$param"
	;;
esac
easycwmp_output "$param" "$val" "$permissions"
return 0
}

get_device_info_object() {
nl="$1"
case "$action" in
	get_name)
	[ "$nl" = "0" ] && easycwmp_output "InternetGatewayDevice.DeviceInfo." "" "0"
	;;
esac
}

get_device_info() {
case "$1" in
	InternetGatewayDevice.)
	get_device_info_object 0
	get_device_info_manufacturer "$2"
	get_device_info_oui "$2"
	get_device_info_product_class "$2"
	get_device_info_serial_number "$2"
	get_device_info_hardware_version "$2"
	get_device_info_software_version "$2"
	get_device_info_uptime "$2"
	get_device_info_device_log "$2"
	get_device_info_specversion "$2"
	get_device_info_provisioningcode "$2"
	return 0
	;;
	InternetGatewayDevice.DeviceInfo.)
	get_device_info_object "$2"
	get_device_info_manufacturer 0
	get_device_info_oui 0
	get_device_info_product_class 0
	get_device_info_serial_number 0
	get_device_info_hardware_version 0
	get_device_info_software_version 0
	get_device_info_uptime 0
	get_device_info_device_log 0
	get_device_info_specversion 0
	get_device_info_provisioningcode 0
	return 0
	;;
	InternetGatewayDevice.DeviceInfo.SpecVersion)
	get_device_info_specversion "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.ProvisioningCode)
	get_device_info_provisioningcode "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.Manufacturer)
	get_device_info_manufacturer "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.ManufacturerOUI)
	get_device_info_oui "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.ProductClass)
	get_device_info_product_class "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.SerialNumber)
	get_device_info_serial_number "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.HardwareVersion)
	get_device_info_hardware_version "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.SoftwareVersion)
	get_device_info_software_version "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.UpTime)
	get_device_info_uptime "$2"
	return $?
	;;
	InternetGatewayDevice.DeviceInfo.DeviceLog)
	get_device_info_device_log "$2"
	return $?
	;;
esac
return $E_INVALID_PARAMETER_NAME
}

set_device_info() {
local fcode
case "$action" in
	set_value)
	fcode=$E_NON_WRITABLE_PARAMETER
	;;
	set_notification)
	fcode=$E_NOTIFICATION_REJECTED
	;;
esac

case "$1" in
	InternetGatewayDevice.)
	[ "$action" = "set_notification" ] && return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.)
	[ "$action" = "set_notification" ] && return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.SpecVersion)
	return $fcode
	;;	
	InternetGatewayDevice.DeviceInfo.Manufacturer)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.ManufacturerOUI)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.ProductClass)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.SerialNumber)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.HardwareVersion)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.SoftwareVersion)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.UpTime)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.DeviceLog)
	return $fcode
	;;
	InternetGatewayDevice.DeviceInfo.ProvisioningCode)
	set_device_info_provisioningcode "$2"
	return 0
	;;	
esac
return $E_INVALID_PARAMETER_NAME
}

build_instances_device_info() { return 0; }

add_object_device_info() { return $E_INVALID_PARAMETER_NAME; }

delete_object_device_info() { return $E_INVALID_PARAMETER_NAME; }

register_function device_info
