// scalac day13.scala && scala day13 && rm day13$.class day13.class
import sys.process._
import scala.language.postfixOps

 object day13 {
    def main(args: Array[String]) = {
        val result = "perl day09.pl res/day13.txt" !!
        val input = result.split(",").map(_.trim).map(_.toInt)
        println(input.grouped(3).count(_(2) == 2))
    }
}
