Attribute VB_Name = "Module2"

Sub FindGreatestValues()

  
    Dim stockRange As Range
    Set stockRange = Range("A1:E10")
 
    Dim stockNames() As String
    Dim percentChanges() As Double
    Dim volumes() As Double
    

    Dim i As Integer
    For i = 2 To stockRange.Rows.Count

        Dim stockName As String
        Dim startingPrice As Double
        Dim endingPrice As Double
        Dim volume As Double
        stockName = stockRange.Cells(i, 1).Value
        startingPrice = stockRange.Cells(i, 2).Value
        endingPrice = stockRange.Cells(i, 3).Value
        volume = stockRange.Cells(i, 5).Value
        
       
        Dim percentChange As Double
        percentChange = (endingPrice - startingPrice) / startingPrice
        

        ReDim Preserve stockNames(i - 2)
        stockNames(i - 2) = stockName
        ReDim Preserve percentChanges(i - 2)
        percentChanges(i - 2) = percentChange
        ReDim Preserve volumes(i - 2)
        volumes(i - 2) = volume
    Next i

    Dim maxPercentIncrease As Double
    Dim maxPercentIncreaseIndex As Integer
    maxPercentIncrease = WorksheetFunction.Max(percentChanges)
    maxPercentIncreaseIndex = WorksheetFunction.Match(maxPercentIncrease, percentChanges, 0)
    Dim stockWithMaxPercentIncrease As String
    If maxPercentIncreaseIndex <= UBound(stockNames) Then
        stockWithMaxPercentIncrease = stockNames(maxPercentIncreaseIndex)
        Range("K2").Value = stockWithMaxPercentIncrease
  
    End If
    
    Dim maxPercentDecrease As Double
    Dim maxPercentDecreaseIndex As Integer
    maxPercentDecrease = WorksheetFunction.Min(percentChanges)
    maxPercentDecreaseIndex = WorksheetFunction.Match(maxPercentDecrease, percentChanges, 0)
    Dim stockWithMaxPercentDecrease As String
    If maxPercentDecreaseIndex <= UBound(stockNames) Then
        stockWithMaxPercentDecrease = stockNames(maxPercentDecreaseIndex)

    End If
    
    Dim maxVolume As Double
    Dim maxVolumeIndex As Integer
    maxVolume = WorksheetFunction.Max(volumes)
    maxVolumeIndex = WorksheetFunction.Match(maxVolume, volumes, 0)
    Dim stockWithMaxVolume As String
    If maxVolumeIndex <= UBound(stockNames) Then
        stockWithMaxVolume = stockNames(maxVolumeIndex)
        Range("L2").Value = stockWithMaxVolume
    Else
        MsgBox "Error: Could not find stock with greatest total volume."
    End If
    
 
    Dim maxPercentIncreaseWithSymbol As String
    maxPercentIncreaseWithSymbol = ""
    For i = 0 To UBound(stockNames)
          If percentChanges(i) = maxPercentIncrease Then
            maxPercentIncreaseWithSymbol = stockNames(i) & " (" & Format(percentChanges(i), "0.00%") & ")"
            Exit For
        End If
    Next i
    
    Range("O2").Value = "Greatest % Increase:"
    Range("O3").Value = "Greatest % Decrease:"
    Range("O4").Value = "Greatest Total Volume:"
    Range("P2").Value = maxPercentIncreaseWithSymbol
    Range("P3").Value = stockWithMaxPercentDecrease
    Range("P4").Value = stockWithMaxVolume
    
End Sub
