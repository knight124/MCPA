clear

clearvars
clearvars -GLOBAL
close all

global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s²


dt  = 1e-9;%time step
f   = 1.602e-18;%force
N= 1;% number of electrons
x   = zeros(N,1);%position
ax  = 0;%average position
v   = zeros(N,1);%velocity
av  = 0;%average velocity

time =0;%array of times for ploting

Tau = 1.9496e-8;
p = 1-exp(-dt/Tau);% probability of colission
efficency = -1.5;%efficency of colition 

for i =1:100
    %checks for colition and sets velocity accordenly
    v=[v,zeros(N,1)];
    for l = 1:N
    if(rand(1)>p)
    v(l,i+1)=v(l,i)+(f/C.m_0)*dt;
    else
     v(l,i+1)=efficency*v(l,i);
    end
    end
    % finds the next position
    x=[x,x(:,i)+(f/C.m_0)*((dt^2)/2)+v(:,i)*dt];
    time=[time,i*dt];
    %drift velocity
    vdx =mean(x(:,i)/(i*dt));
    p=p*0.94;% decreases the probability of colitions with time
    ax = [ ax,mean( mean(x,2))];
    av = [av,mean(mean(v,2))];
    subplot(3,1,1)
    plot(time,x,'-',time,ax,'g-s')
    ylabel('Position (m)')
    xlabel('Time(s)')
    title('position vs time')
    subplot(3,1,2)
    plot(time,v,'-',time,av,'g-s')
    xlabel('Time(s)')
    ylabel('Velocity (m/s)')
    title('Velocity vs time')
    subplot(3,1,3)
    plot(mean(x,1),mean(v,1),'-')
    title('average Velocity vs average position')
    xlabel('Position (m)')
    ylabel('Velocity (m/s)')
    str = sprintf('Drift velocity: %0.5e',vdx);
    set(gcf,'NumberTitle','off') %don't show the figure number
    set(gcf,'Name',str) %select the name of the figure
    drawnow
end 