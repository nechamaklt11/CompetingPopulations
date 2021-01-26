function Outstruct = dnf_knownSim(instruct1, instruct2)
%Question 2, Section 2J

%The function runs a simulation with known parameters on two populations.
%Inputs: Instruct1 - a structure array containing a structure for each
%population (as described in 1)E)ii), Instruct2 - a structure containing
%the simulation parameters (as described in 1)E)i)
%Output: a structure containing the simulation results (as described in
%1)E)iii)
pop1 = nan(instruct2.maxSteps+1, instruct2.numRepeats);
pop1Data = instruct1(1); %Calling the struct containing the data for species 1 into its own variable
pop1(1,:) = pop1Data.N0;
pop2 = nan(instruct2.maxSteps+1, instruct2.numRepeats);
pop2Data = instruct1(2); %Calling the struct containing the data for species 2 into its own variable
pop2(1,:) = pop2Data.N0;

for i=1:instruct2.maxSteps 
    nextGen1=calcNextGen(instruct1(1),pop1(i,:),pop2(i,:)); %calculate the next generation size of first species.
    nextGen2=calcNextGen(instruct1(2),pop2(i,:),pop1(i,:)); %calculate the next generation size of second species.
    if instruct2.numRepeats>1 %for a stochastic simulation with more than one repeat
        nextGen1=randomRound(nextGen1); %randomly round to an integer size of 1st population
        nextGen2=randomRound(nextGen2); %randomly round to an integer size of 2nd population
        nextGen1(nextGen1<instruct2.minSize)=0; %zero values that are smaller than the population minimum size
        nextGen2(nextGen1<instruct2.minSize)=0;
        if all(nextGen1==0) || all(nextGen2==0) %break the loop if one of the population sizes is zero
            break
        end
    end
    pop1(i+1,:)=nextGen1; %update the size of the next generation for the 1st population
    pop2(i+1,:)=nextGen2; %update the size of the next generation for the 2nd population
end
pop1(isnan(pop1))=[]; %delete empty rows for the 1st population
pop2(isnan(pop2))=[]; %delete empty rows for the 2nd population
Outstruct.Pop1=pop1; Outstruct.Pop2=pop2; %updating the output struct with the calculated generation sizes
Times=0:size(pop1,1)-1; %The time vector equals to the number of steps done
Outstruct.Times=Times'; %update the outpus struct with the Times vector calculated above

function nextGen = calcNextGen(popData,lastGen,compLastGen) %Function to calculate the population in the next generation
nextGen = lastGen.*popData.lamda.^(1-((lastGen+popData.alpha.*compLastGen)./popData.K));


function randOut = randomRound(Num) %Function to randomly round a number to a whole
fractional = Num - floor(Num); %Finding the fractional part of each number
randArray = rand(size(Num)); %Create a random array of fractions between 0 and 1
roundUp = fractional>randArray;%Find positions of fractional parts larger than the random array
roundDown = fractional<randArray; %Find positions of fractional parts smaller than the random array
randOut = Num;
randOut(roundUp) = ceil(Num(roundUp)); %Replace the original numbers with the ones round up
randOut(roundDown) = floor(Num(roundDown)); %Replace the original numbers with the ones rounded down
