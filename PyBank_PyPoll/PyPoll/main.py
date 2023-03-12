import csv
import os
# Define the file path
file_path = os.path.join("PyPoll","Resources","election_data.csv")

# Initialize variables to store results
total_votes = 0
candidate_votes = {}
candidates = []

# Read the CSV file
with open(file_path, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")
    next(csvreader) # Skip the header row
    for row in csvreader:
        # Count the total number of votes
        total_votes += 1
        # Extract the candidate name from the row
        candidate = row[2]
        # If the candidate is not in the list of candidates, add them
        if candidate not in candidates:
            candidates.append(candidate)
            candidate_votes[candidate] = 0
        # Add a vote to the candidate's total
        candidate_votes[candidate] += 1

# Calculate and print the results
print("Election Results")
print("-------------------------")
print(f"Total Votes: {total_votes}")
print("-------------------------")
for candidate in candidates:
    vote_count = candidate_votes[candidate]
    vote_percent = vote_count / total_votes * 100
    print(f"{candidate}: {vote_percent:.3f}% ({vote_count})")
print("-------------------------")
winner = max(candidate_votes, key=candidate_votes.get)
print(f"Winner: {winner}")
print("-------------------------")

# Write the results to a text file
with open("election_results.txt", "w") as textfile:
    textfile.write("Election Results\n")
    textfile.write("-------------------------\n")
    textfile.write(f"Total Votes: {total_votes}\n")
    textfile.write("-------------------------\n")
    for candidate in candidates:
        vote_count = candidate_votes[candidate]
        vote_percent = vote_count / total_votes * 100
        textfile.write(f"{candidate}: {vote_percent:.3f}% ({vote_count})\n")
    textfile.write("-------------------------\n")
    textfile.write(f"Winner: {winner}\n")
    textfile.write("-------------------------\n")
