# NLP Lane Change
A Non-Linear Programing Optimization formulation to optimize the control of an autonomous vehicle lane change.

## Optimization Formulation
Optimize the vehicle controls for a lane change that maximizes *ride quality* while satisfying the following conditions:
* Performs the lane change in a specified distance and maximum amount of time
* Remains within the limits of the road
* Specified start/end speed
* Start and end at steady state velocity & yaw rate and aligned with the road

## Limitations
* Straight road (no curvature)
* No other vehicles in the scene
* Simple linear bicycle model 

## Dependecies
* [IPOPT](https://projects.coin-or.org/Ipopt)
* [ADOL-C](https://projects.coin-or.org/ADOL-C)
* [Eigen](https://eigen.tuxfamily.org/)