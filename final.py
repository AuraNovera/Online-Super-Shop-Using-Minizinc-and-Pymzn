import pymzn
loop = "y"
while loop == "y" or loop == "Y" :
    num = float(input("Enter your choice: 1. Family Package 2. Single Package \n"))
    if num == 1:
        solns = pymzn.minizinc('G:/3-2/Labs/AI Lab/minizinc project/final/co1.mzn','G:/3-2/Labs/AI Lab/minizinc project/final/co1.dzn', all_solutions=True, output_mode='item')
        print("Number of solutions found:")
        print(len(solns))
        best=len(solns)
        print("Best optimized products & budget for your family: ")
        print(solns[-1])
        # print(solns)
        print("\n")

    elif num == 2:
        solns2 = pymzn.minizinc('G:/3-2/Labs/AI Lab/minizinc project/final/so1.mzn','G:/3-2/Labs/AI Lab/minizinc project/final/so1.dzn', all_solutions=True, output_mode='item')
        #print(type(solns).__name__)
        print("Number of solutions found:")
        print(len(solns2))
        #best2=len(solns2)
        #print(best2)
        print("Best optimized sized products for a single person: ")
        print(solns2[-1])
        # print(solns2)
        print("\n")

    loop = str(input("Continue Y/N? \n"))