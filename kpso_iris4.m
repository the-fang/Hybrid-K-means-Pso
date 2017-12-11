%K-PSO algorithm on IRIS dataset c=4.................


clear
clc
n = 297;         
bird_setp  = 50; 
dim = 4;          

c2 =1.2;          
c1 = 1.2;        
w =0.9;           
fitness=0*ones(n,bird_setp);
xdat = load('kmean_iris4.dat');
                                     
                                       %    initialize the parameter %
                                      
                                       
R1 = rand(dim, n);
R2 = rand(dim, n);
current_fitness =0*ones(n,1);

                               
                                 % Initializing swarm and velocities and position %
                                
                                 
current_position = 10*(rand(dim, n)-.5);
velocity = .3*randn(dim, n) ;
local_best_position  = current_position ;


                                
                                 %     Evaluate initial population           %           
                                 
for i = 1:n
    current_fitness(i) = Live_fn(current_position(:,i));    
end


local_best_fitness  = current_fitness ;
[global_best_fitness,g] = min(local_best_fitness) ;

for i=1:n
    globl_best_position(:,i) = local_best_position(:,g) ;
end
                                              
                                               %  VELOCITY UPDATE  %
                                               

velocity = w *velocity + c1*(R1.*(local_best_position-current_position)) + c2*(R2.*(globl_best_position-current_position));

                                              
                                               %   SWARMUPDATE    %
                                              
                                               
            
current_position = current_position + velocity ;

                                              
                                               %  evaluate anew swarm   %
                                               
                                               

%% Main Loop
tic
iter = 0 ;        % Iterationscounter
while  ( iter < bird_setp )
iter = iter + 1;

for i = 1:n,
current_fitness(i) = Live_fn(current_position(:,i)) ;    

end


for i = 1 : n
        if current_fitness(i) < local_best_fitness(i)
           local_best_fitness(i)  = current_fitness(i);  
           local_best_position(:,i) = current_position(:,i)   ;
        end   
 end

  
 [current_global_best_fitness,g] = min(local_best_fitness);
  
    
if current_global_best_fitness < global_best_fitness
   global_best_fitness = current_global_best_fitness;
   
    for i=1:n
        globl_best_position(:,i) = local_best_position(:,g);
    end
   
end


 velocity = w *velocity + c1*(R1.*(local_best_position-current_position)) + c2*(R2.*(globl_best_position-current_position));
 current_position = current_position + velocity; 
  
 

 
x=current_position(1,:);
y=current_position(2,:);

clf    
    plot(x, y , 'h')   
    axis([-5 5 -5 5]);
    
pause(.2)


end
cp=current_position';% end of while loop its mean the end of all step that the birds move it
                      

              [Jbest_min,I] = min(current_fitness) % minimum fitness
               current_position(:,I) % best solution
disp(cp);
               
toc
