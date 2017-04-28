#ifndef CAR_H
#define CAR_H

#include <Eigen/Dense>

using namespace Eigen;

class Car {

    private:

        VectorXd x; // States
        double vxCar;
        double vyCar;
        double nCar;
        VectorXd x_dot; // State derivatives
        double vyCar_dot;
        double nCar_dot;
        VectorXd u; // Control inputs
        double aSteer;
        double vxCar_dot;

        double aSlipF; // Front tire slip [rad]
        double aSlipR; // Rear tire slip [rad]
        double FyTireF; // Front lateral tire force [N]
        double FyTireR; // Rear lateral tire force [N]

    public:

        double mCar;  // Vehicle mass [kg]
        double ICar;  // Vehicle inertia [kg-m2]
        double a;  // Distance from CG to front axle [m]
        double b;  // Distance from CG to rear axle [m]
        double kSlipF; // Front tire cornering stiffness [N/rad]
        double kSlipR; // Rear tire cornering stiffness [N/rad]

        Car(); // Constructor
        virtual ~Car(); // Destructor
        CalculateStateDerivatives(); // Calculate model state derivatives

};

#endif /* CAR_H */
