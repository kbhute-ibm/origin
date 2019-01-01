#!/usr/bin/env groovy

def call(){
def GOPATH = pwd();
	stage('Check Distro'){
		println "PackageName : " + "ngnix" + " SaidVersionInRecipe : " + "1.10.3";
		
		withEnv(["PNAME=nginx","SaidVersionInRecipe=1.10.3"]){
			script { 
				sh '''
				
				if [ -f "/etc/os-release" ]; then
					. /etc/os-release
				else
					echo "No /etc/os-release file found hence defaulting it to rhel";
					export ID="rhel"
				fi
				if [ $ID == "rhel" ]; then
				    echo "Detected RHEL"
				    source /home/test/.bashrc
				    sudo rpm --rebuilddb
					available_version=$(sudo yum info $PNAME | grep Version | head -1 | cut -d ':' -f 2| cut -d ' ' -f 2)
				elif [ $ID == "sles" ]; then
					sudo zypper update -y
					available_version=$(sudo zypper info $PNAME | grep Version | head -1 | cut -d ':' -f 2| cut -d ' ' -f 2)
				elif [ $ID == "ubuntu" ]; then
				    echo "Detected Ubuntu"
				    sudo apt-get update
					available_version=$(sudo apt-cache policy $PNAME | grep Candidate | head -1 | cut -d ' ' -f 4)
				fi
			
			    echo "Available Version in repo : $available_version " 
				if [[ $available_version == *"$SaidVersionInRecipe"* ]]; then
					echo "Version $SaidVersionInRecipe is not same as available in repo"
    				echo "Exact name: $available_version ... Failing"
    				exit 1
				else	
   					echo "Said Version In Recipe is same as available in repo. Going ahead."     
				fi
			''' 
				
			}
		}
		
	}
}
