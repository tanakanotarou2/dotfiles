#![allow(unused_imports)]
#![allow(dead_code)]
#![allow(non_snake_case)]
use proconio::input;
use proconio::marker::{Bytes, Chars, Usize1};
use itertools::Itertools;
use std::cmp::{min, max};
use superslice::Ext; // lower_bound, upper_bound

fn main() {
    input! {
        // n:usize,
        // m:usize,
        // a:[usize;n],
        // var:[(usize,usize,usize);n]
    }

}

/////////////////////////////////////////////////
const JU_4: usize = 10_000;
const JU_5: usize = 100_000;
const JU_9: usize = JU_5 * 10_000;
const JU_18: usize = JU_9 * JU_9;
const INF: usize = JU_9 + 100_100;
const INFL: usize = JU_18 * 2;

trait SetMinMax { fn setmin(&mut self, v: Self) -> bool; fn setmax(&mut self, v: Self) -> bool; }
impl<T> SetMinMax for T where T: PartialOrd { 
    fn setmin(&mut self, v: T) -> bool { *self > v && { *self = v; true } }
    fn setmax(&mut self, v: T) -> bool { *self < v && { *self = v; true } }
}
trait Print{ fn println(&self); }
impl<T> Print for Vec<T> where T: std::fmt::Display{
    fn println(&self){ println!("{}",self.iter().join(" ")); }
}

fn Yes(){ println!("Yes"); }
fn No(){ println!("No"); }
