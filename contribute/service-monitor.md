## How to add new serviceMonitor for a CAS type.
To add serviceMonitor, you only need to add configuration in [config.libsonnet](jsonnet/../../jsonnet/config.libsonnet).  

Example:  
- To add serviceMonitor for mayastor:
	```
	. . .
	_config+:: {
		. . .
		// Configuration for different cas types.
		casType: {
			mayastor: {
				serviceMonitor: serviceMonitor(<PORTt>, <PATH>, <SELECTOR_NAME>) {
					enabled: true,
					endpoints+: {
						. . .
					}
				}
			}
		}
	}
	. . . 
	```