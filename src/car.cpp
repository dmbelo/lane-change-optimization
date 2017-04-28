#include "car.h"

using namespace Eigen;

Car::Car() {

    mCar = 1000;
    ICar = 1e5;
    a = 0.5;
    b = 0.5;
    kSlipF = 1000;
    kSlipR = 1000;

    x = VectorXd::Zero(3);
    u = VectorXd::Zero(2);

}

Car::~Car() {}

Car::CalculateStateDerivatives() {

    vxCar = x(0);
    vyCar = x(1);
    nCar = x(2);

    aSteer = u(0);
    vxCar_dot = u(1);

    aSlipF = (vyCar + a * nCar)/vxCar - aSteer;
    aSlipR = (vyCar - b * nCar)/vxCar;
    FyTireF = kSlipF * aSlipF;
    FyTireR = kSlipR * aSlipR;
    
    vyCar_dot = 1/mCar * (FyTireF + FyTireR);
    nCar_dot = 1/ICar * (a * FyTireF - b * FyTireR);

    x_dot(0) = vxCar_dot;
    x_dot(1) = vyCar_dot;
    x_dot(3) = nCar_dot;

}