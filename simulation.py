import math
def ROM_lookup(iteration):
    return (math.atanh(2**(-1*iteration)))
    
    

def complement(input_str):
    firstOneFound = False
    input_list = list(input_str[::-1])  # Reverse the string

    for i in range(len(input_list)):
        if firstOneFound:
            input_list[i] = '0' if input_list[i] == '1' else '1'
        if input_list[i] == '1' and not firstOneFound:
            firstOneFound = True

    return ''.join(input_list[::-1])  # Reverse back to original order

def convert_to_fixed_point(data, integralWidth, fractionWidth):
    isNegative = False
    if data < 0:
        data = -data
        isNegative = True

    # Integral part
    t = []
    for i in range(integralWidth - 1, -1, -1):
        if data - 2 ** i >= 0:
            t.append('1')
            data -= 2 ** i
        else:
            t.append('0')
    t = ''.join(t[::-1])  # Reverse to get the correct order

    # Fractional part
    z = []
    for i in range(1, fractionWidth + 1):
        if data - 2 ** (-i) >= 0:
            z.append('1')
            data -= 2 ** (-i)
        else:
            z.append('0')
    z = ''.join(z)

    result = t + z
    if isNegative:
        result = complement(result)
    return result


def rotation_mode(x, y, z, iterations):
    a = 0.607252935;   # = 1/K
    
    x_val_list = []
    y_val_list = []
    z_val_list = []
    iterations_list = []

    i = 0;                  # Keeps count on number of iterations
    
    current_x = x         # Value of X on ith iteration 
    current_y = y         # Value of Y on ith iteration
    current_z = z         # Value of Z on ith iteration
    
    di = 0
    
    i = 1
        
    flag = 0
    
    if (iterations > 0):
        while (i < iterations):
            if (current_z < 0):
                di = -1
            else:
                di = +1
            next_z = current_z - di * ROM_lookup(i)
            print(i)
            print(ROM_lookup(i))
            print(convert_to_fixed_point(ROM_lookup(i), 4, 16))
            next_x = current_x  + di * current_y * (2**(-1*i))
            next_y = current_y + di * current_x * 2**(-1*i)
            
            current_x = next_x
            print("x:", current_x)
            current_y = next_y
            print("y:", current_y)
            current_z = next_z
            print("z:", current_z)
            

            x_val_list.append(current_x)
            y_val_list.append(current_y)
            z_val_list.append(current_z)
            
            iterations_list.append(i)
            
            
            if ((i != 4) & (i != 13) & (i!=40)):
                i = i+1
            elif (flag == 0):
                flag = 1
            elif (flag == 1):
                flag = 0
                i = i+1
    return { 'x':x_val_list, 'y':y_val_list, 'z':z_val_list, 'iteration':iterations_list, }


print(rotation_mode(1,0,0.5,21))