#include <iostream>
#include <fstream>
#include <cmath>
#include <numbers>

using namespace std;

int main(){
    const double gamma = 1.4;
    double mu, beta, theta;
    const double pi = std::numbers::pi;
    ofstream file("theta_beta_M.csv");
    if (!file.is_open()) {
        cerr << "Failed to open output file\n";
        return 1;
    }
    file << "M1,Beta,Theta,M2\n";
    for (double M = 1.0; M <= 10.0; (M<2)?M += 0.1:M += 0.5) {
        mu = asin(1.0 / M)*180.0/pi;
        for(beta = mu; beta <= 90.0; beta += 0.1) {
            double beta_rad = beta * pi / 180.0;
            theta = atan(2.0 * (1.0 / tan(beta_rad)) * ((M * M * sin(beta_rad) * sin(beta_rad) - 1.0) / (M * M * (gamma + cos(2.0 * beta_rad)) + 2.0))) * 180.0/pi;
            if (theta < 0.0) theta = 0.0;
            // downstream Mach number behind the oblique shock
            double M1n = M * sin(beta_rad);
            double M2n = sqrt((1.0 + 0.5 * (gamma - 1.0) * M1n * M1n) /(gamma * M1n * M1n - 0.5 * (gamma - 1.0)));
            double M2 = M2n / sin(beta_rad - theta * pi / 180.0);
            file << M << "," << beta << "," << theta << "," << M2 << "\n";
        }
    }
    file.close();
    cout << "Wrote theta_beta_M.csv\n";   
    return 0;
}