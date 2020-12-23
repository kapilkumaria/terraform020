
resource "aws_eip" "eip" {
   
   tags = {
     Name = "kapil_nat_eip"
   }
}


output "eip_id" {
   value = aws_eip.eip.id
}
    
