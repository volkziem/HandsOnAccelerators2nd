#!../../bin/linux-arm/test2

## You may have to change test2 to something else
## everywhere it appears in this file

< envPaths

#......added
epicsEnvSet(STREAM_PROTOCOL_PATH,"../../test2App/Db")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/test2.dbd"
test2_registerRecordDeviceDriver pdbbase

#......added
drvAsynSerialPortConfigure("SERIALPORT","/dev/ttyACM0",0,0,0)
asynSetOption("SERIALPORT",-1,"baud","9600")
asynSetOption("SERIALPORT",-1,"bits","8")
asynSetOption("SERIALPORT",-1,"parity","none")
asynSetOption("SERIALPORT",-1,"stop","1")
asynSetOption("SERIALPORT",-1,"clocal","Y")
asynSetOption("SERIALPORT",-1,"crtscts","N")
dbLoadRecords("db/arduino2.db","PORT='SERIALPORT',USER='raspi'")

## Load record instances
#dbLoadRecords("db/xxx.db","user=pi")

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncxxx,"user=pi"
