*** Settings ***
Library JunosDevice.py

*** Test Cases ***
Check Hostname
	Connect	host=${HOST}	port=${PORT}	user=${USER}	password=${PASSWORD}
	${hostname}=	Get Hostname
	Should Be Equal As Strings	${hostname}	vqfx1
	Close

Check Model
	Connect	host=${HOST}	port=${PORT}	user=${USER}	password=${PASSWORD}
	${model}=	Get Model
	Should Be Equal As Strings	${model}	VQFX-10000
	Close

Check Version
	Connect	host=${HOST}	port=${PORT}	user=${USER}	password=${PASSWORD}
	${version}=	Get Version
	Should Be Equal As Strings	${version}	18.3R1.9
	Close

Confirm Two BGP Peers are Configured
	Connect	host=${HOST}	port=${PORT}	user=${USER}	password=${PASSWORD}
	${peercount}=	BGP Peer Count
	Should Be Equal As Integers	${peercount}	2
	Close

Confirm All BGP Peers are Established
	Connect	host=${HOST}	port=${PORT}	user=${USER}	password=${PASSWORD}
	${peercount}=	BGP Peer Count
	${estpeercount}=	BGP Peer Count	Established
	Should Be Equal As Integers	${estpeercount}	${peercount}
	Close
