function Outstruct = dnf_knownSim(instruct1, instruct2)
%Section 2J

pop1 = nan(instruct2.maxSteps, instruct2.numRepeats);
pop1Data = instruct1(1); %Calling the struct containing the data for species 1 into its own variable
pop1(1,:) = pop1Data.N0;
pop2 = nan(instruct2.maxSteps, instruct2.numRepeats);
pop2Data = instruct1(2); %Calling the struct containing the data for species 2 into its own variable
pop2(1,:) = pop2Data.N0;

function nextGen = calcNextGen(popData,lastGen,compLastGen) %Function to calculate the population in the next generation
nextGen = lastGen.*popData.lamda.^(1-((lastGen+popData.alpha.*compLastGen)./popData.K));
function randOut = randomRound(Num) %Function to randomly round a number to a whole
fractional = Num - floor(Num); %Finding the fractional part of each number
randArray = rand(size(Num)); %Create a random array of fractions between 0 and 1
roundUp = fractional>randArray;%Find positions of fractional parts larger than the random array
roundDown = fractional<randArray; %Find positions of fractional parts smaller than the random array
randOut = Num;
randOut(roundUp) = round(Num(roundUp)); %Replace the original numbers with the ones round up
randOut(roundDown) = floor(Num(roundDown)); %Replace the original numbers with the ones rounded down