%K-PSO algorithm on heart disease dataset c=4.................


n = 297;          
bird_setp  = 100; 
dim = 4;          

c2 =1.49;         
c1 = 1.49;        
w =0.72;            
fitness=0*ones(n,bird_setp);
xdat = load('kmean_heart_c4.dat');

                                      
                                       
R1 = rand(dim, n);
R2 = rand(dim, n);
current_fitness =0*ones(n,1);

current_position = xdat';
velocity = 0*ones(dim, n) ;      
local_best_position  = current_position ;


                                
for i = 1:n
    current_fitness(i) = Live_fn(current_position(:,i));    
end


local_best_fitness  = current_fitness ;
[global_best_fitness,g] = min(local_best_fitness) ;

for i=1:n
    globl_best_position(:,i) = local_best_position(:,g) ;
end
                                               

velocity = w *velocity + c1*(R1.*(local_best_position-current_position)) + c2*(R2.*(globl_best_position-current_position));

current_position = current_position + velocity ;
                                              
tic

iter = 0 ;      
while  ( iter < bird_setp )
iter = iter + 1;

for i = 1:n
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
  axis([-9 9 -9 9]);
    
 pause(.1)
  
 
end 

cp=current_position';

for j=1:n
     p=max(cp);
     P=p/cp(j);
end

for m=1:dim
     for j=1:n
         OP=cp(j)*P/dim;
     end
end

%fitness evaluation
for i=1:dim
  for j=1:n
     f1=xdat(i)-cp(j)/n; 
  end
end
 
f=f1/dim;

[Jbest_min,I] = min(current_fitness);
[Jbest_max,I] = max(current_fitness);

disp(max(OP));
disp(f1);
disp(cp);
                       
toc
              
         