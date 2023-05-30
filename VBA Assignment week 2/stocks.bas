Attribute VB_Name = "Module1"
Sub StockAnalysis()

Dim ticker As String
Dim lastRow As Long
Dim openingPrice As Double
Dim closingPrice As Double
Dim yearlyChange As Double
Dim percentageChange As Double
Dim totalVolume As Double


Dim outputRow As Long
outputRow = 2

lastRow = Cells(Rows.Count, 1).End(xlUp).Row


Range("I1").Value = "Ticker"
Range("J1").Value = "Yearly Change"
Range("K1").Value = "Percentage Change"
Range("L1").Value = "Total Volume"

For i = 2 To lastRow
    
   
    If Cells(i, 1).Value <> Cells(i - 1, 1).Value Then
        openingPrice = Cells(i, 3).Value
        totalVolume = Cells(i, 7).Value
    Else
      
        totalVolume = totalVolume + Cells(i, 7).Value
    End If
    
    If Cells(i, 1).Value <> Cells(i + 1, 1).Value Then
        closingPrice = Cells(i, 6).Value
        
       
        yearlyChange = closingPrice - openingPrice
        If openingPrice = 0 Then
            percentageChange = 0
        Else
            percentageChange = yearlyChange / openingPrice
        End If
        
        Range("I" & outputRow).Value = Cells(i, 1).Value
        Range("J" & outputRow).Value = yearlyChange
        Range("K" & outputRow).Value = percentageChange
        Range("L" & outputRow).Value = totalVolume
    
        Range("K" & outputRow).NumberFormat = "0.00%"
        
     
        outputRow = outputRow + 1
    End If
    
Next i

End Sub

